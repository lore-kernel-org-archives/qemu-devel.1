Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0986CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CD720730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="0COIrCQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CD720730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyz5T-0007Rn-0V
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1iyz4o-0006gg-Qw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1iyz4n-0003ka-J4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:21:18 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1iyz4n-0003jl-DO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:21:17 -0500
Received: by mail-wm1-x344.google.com with SMTP id q9so3483617wmj.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=cUouDRemLbnIXlZdvvQvdCD8Duy7fIhHYbJqhQ5Y/dU=;
 b=0COIrCQpvQbZuj0GejLg8pjvIx4J8UA87uclSvcZrssfdahMqIGL352w20wBVYLQhB
 YPR8p5vZDIMr0+MWl2KQJ/n33nVxv0DB94+zDU4TSJq7WKZDVdkIDXHjpuFBXXrbXdhq
 /MYWq1s8EsAH3ntQ3iFknaY2L2XZnI0PSPOc6ra9p4UOtdBA4B8vmAjvyQgq1ursBeRm
 Om4OvPPSbhnkgx6jPZQg90Jqr3Ceu09e4YiS7L3juDJh74baCLHIquF7WXkMikeNvBQM
 LvNZoWCt1yYF8ypExrds3YLlDKSWvPFR7D3MKWSDOPPZxe06nT0Ibgm4ihvfmd0VbzmU
 qFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=cUouDRemLbnIXlZdvvQvdCD8Duy7fIhHYbJqhQ5Y/dU=;
 b=LiH3hG3E7SGUoWEH18Mvdt0m61YAzUtNi8HLq/JZdEn8KSirD624OVNF889daEpWyU
 XLC8wkv5Fwc7TKWWb+uVlYAK4+8OMWRnljYPzZawvAa6pgLiRn45p31av6oeB0L0uyOa
 U9hrAcMJZ8OnyHi5vbQswVwELpHe8ZlcIhzYQIs1+DAj5ZbbcXvQZmjgRj9fCOxG3L7j
 WyrVaoygmaqbWyA44NMrFLJOyPON4aFL/t/p7ANSQEV04xv/nB+4adeZnPxHQOOJJ8AJ
 pQdNzWHIZxH+bIcr9zG01Ki069yEZR4V8Zx5/s6GGqG3PYNz5cBS3ihyy3bSrC4FxifZ
 Y3lw==
X-Gm-Message-State: APjAAAUYlOYuAGjA/sqdC27SywxnZUb8QXHUPi2KZCNHAD2JyvK4uGXS
 l/1Rbk14UvlbiK7hakkEuPrcuK9qei4=
X-Google-Smtp-Source: APXvYqzXIXw8+H2t/SX047CGbjAO3Wobi0IlQaWQUyNwscHkGc/jtm8SINAisPh534QICnJCvw0iPQ==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr5854941wme.153.1580826075840; 
 Tue, 04 Feb 2020 06:21:15 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [81.149.164.25])
 by smtp.gmail.com with ESMTPSA id u8sm4034308wmm.15.2020.02.04.06.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 06:21:15 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id bb572ab6;
 Tue, 4 Feb 2020 14:21:14 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
In-Reply-To: <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
X-HGTTG: gag-halfrunt
From: David Edmondson <dme@dme.org>
Date: Tue, 04 Feb 2020 14:21:14 +0000
Message-ID: <cunftfqsaat.fsf@gag-halfrunt.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tuesday, 2020-02-04 at 07:31:52 -06, Eric Blake wrote:

> On 2/4/20 3:52 AM, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>
> 'filled with zeroes' is accurate for a preallocated image, but reads 
> awkwardly for a sparse image; it might be better to state 'reads as zero'.

Okay.

>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>> 
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
>> 
>> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
>> ---
>>   docs/interop/qemu-img.rst |  8 +++++++-
>>   qemu-img-cmds.hx          |  4 ++--
>>   qemu-img.c                | 25 ++++++++++++++++++++++---
>>   3 files changed, 31 insertions(+), 6 deletions(-)
>> 
>> diff --git a/docs/interop/qemu-img.rst b/docs/interop/qemu-img.rst
>> index fa27e5c7b453..99bdbe4740ee 100644
>> --- a/docs/interop/qemu-img.rst
>> +++ b/docs/interop/qemu-img.rst
>> @@ -214,6 +214,12 @@ Parameters to convert subcommand:
>>     will still be printed.  Areas that cannot be read from the source will be
>>     treated as containing only zeroes.
>>   
>> +.. option:: --target-is-zero
>> +
>> +  Assume that the destination is filled with zeros. This parameter is
>
> Spelled 'zeroes' just three lines earlier.

My understanding is that "zeros" is the correct plural of "zero" (and
that "zeroes" relates to the use of "zero" as a verb), but perhaps
that's another British English thing?

I don't care enough to fight about it.

>> +  mutually exclusive with the use of a backing file. It is required to
>> +  also use the ``-n`` parameter to skip image creation.
>
> I understand that it is safer to have restrictions now and lift them 
> later, than to allow use of the option at any time and leave room for 
> the user to shoot themselves in the foot with no way to add safety 
> later.  The argument against no backing file is somewhat understandable 
> (technically, as long as the backing file also reads as all zeroes, then 
> the overall image reads as all zeroes - but why have a backing file that 
> has no content?); the argument requiring -n is a bit weaker (if I'm 
> creating an image, I _know_ it reads as all zeroes, so the 
> --target-is-zero argument is redundant, but it shouldn't hurt to allow it).

Given your patchset that improves the general behaviour of zero
detection, I'm definitely inclined to leave the backing file case alone
in this patch.

Convincing myself that a newly created image can only ever read as zero
will take a little more time, which I'm happy to spend if it's
considered significant.

>> +++ b/qemu-img.c
>
>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>>           warn_report("This will become an error in future QEMU versions.");
>>       }
>>   
>> +    if (s.has_zero_init && !skip_create) {
>> +        error_report("--target-is-zero requires use of -n flag");
>> +        goto fail_getopt;
>> +    }
>
> So I think we could drop this hunk with no change in behavior.
>
>> +
>>       s.src_num = argc - optind - 1;
>>       out_filename = s.src_num >= 1 ? argv[argc - 1] : NULL;
>>   
>> @@ -2380,6 +2394,11 @@ static int img_convert(int argc, char **argv)
>>       }
>>       s.target_has_backing = (bool) out_baseimg;
>>   
>> +    if (s.has_zero_init && s.target_has_backing) {
>> +        error_report("Cannot use --target-is-zero with a backing file");
>> +        goto out;
>> +    }
>> +
>
> while keeping this one makes sense.  At any rate, typo fixes are minor, 
> and whether or not we drop the hunk I claim is a needless restriction 
> against redundancy,
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks.

dme.
-- 
Everyone I know, goes away in the end.

