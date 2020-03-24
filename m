Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C045DC2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0DC206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvgIHv55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0DC206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjkw-0002GJ-P0
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGjk3-0001S2-LN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGjk2-00085q-8Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:37:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43491)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGjk1-00085C-NJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585057032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pY8FniGIIGd09a6Ebnnbv5znogfkIkzJmCv+eY9rfA=;
 b=TvgIHv55iYKtvC7/x+AnNiWKz+RMtJn9QgHLcWW6hbqD6BQsYVVbvs9pAieVqFAfY3zB7R
 DpJYMxfDdqqB7UKZsn+ujtYa9Sf2hvf19cExZC9AkgW4OxFFqOgDxPpwKecprP9QyDSfnc
 efITIKQm+Fa5rJmufkyAxghIjl1ViKc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-tfGQVDmUNLmo-WNiGoGdbA-1; Tue, 24 Mar 2020 09:37:08 -0400
X-MC-Unique: tfGQVDmUNLmo-WNiGoGdbA-1
Received: by mail-ed1-f71.google.com with SMTP id k7so10647019edn.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RFNdCBw5cT72IhYskCakHYs6lXfX127TWHibTqdFoY0=;
 b=h3xRiUqLKQgutV0+7sR43XRkk/b495Z4cnEHm7ljUhlyQxnd/1Ej03J9Gsfzh/GtZW
 qea++4q/VeZmR3LGbv8w2TcwC2Xzmq9FO5Jw/lNZrTtzTOE3jPeexSLAobBoIL380iPu
 wPJw8Aya1lekOufcuXiyKndtdsXcyI+bHnPUB/fGTz81GOYgucE5psUrV3FvnWrtV1fU
 KvPLc7QBUcLB+pKrDG/JZZTpzT53f8NwniNZ7gwZbjecf+Gy54aUwNyL0j0fzrvDBTDD
 Oeh8zWev6GOxUr4qOjfOXvEHU9AbSMvzner1nl/EdslFaRinMUE2dAKsggUzYpl85x2B
 xJOw==
X-Gm-Message-State: ANhLgQ0gCzffNRXoIxqrHZNvcXl4tY4BGENoQNde8zZ7exdbiaZ/Rdlh
 TffbuwurW3QPi9UZvA0BCuv+DM0JgULPWiRDHw/b9NiVOOtXmEhowlYgicaXQbtb6C68Z4shV0E
 FsJZUDlB040KgCx4=
X-Received: by 2002:aa7:d383:: with SMTP id x3mr6728318edq.222.1585057027264; 
 Tue, 24 Mar 2020 06:37:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvJHr9nNgUeCo2atthcwGES8/4lreivEP4+kMIwAADL00oMwZV/RgelU+JFuMIBYy+bQr+TLw==
X-Received: by 2002:aa7:d383:: with SMTP id x3mr6728297edq.222.1585057027054; 
 Tue, 24 Mar 2020 06:37:07 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id l2sm1295557edk.70.2020.03.24.06.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:37:06 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] qga-win: prevent crash when executing
 guest-file-read with large count
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Basil Salman <basil@daynix.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20200311170417.13415-1-basil@daynix.com>
 <20200311170417.13415-4-basil@daynix.com>
 <26fa941f-b578-06e7-947e-34ab426097bc@redhat.com>
Message-ID: <75a7f7f7-c0b5-a584-c117-fd1eb6218d6c@redhat.com>
Date: Tue, 24 Mar 2020 14:37:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <26fa941f-b578-06e7-947e-34ab426097bc@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 2:20 PM, Philippe Mathieu-Daud=E9 wrote:
> On 3/11/20 6:04 PM, Basil Salman wrote:
>> BZ: #1594054
>=20
> ^ This is not very helpful as it... (think to ppl with no knowledge of=20
> 'BZ', what to do with this number). Instead ...
>=20
>> guest-file-read command is currently implemented to read from a
>> file handle count number of bytes. when executed with a very large=20
>> count number
>> qemu-ga crashes.
>> after some digging turns out that qemu-ga crashes after trying to=20
>> allocate
>> a buffer large enough to save the data read in it, the buffer was=20
>> allocated using
>> g_malloc0 which is not fail safe, and results a crash in case of failure=
.
>> g_malloc0 was replaced with g_try_malloc0() which returns NULL on=20
>> failure,
>> A check was added for that case in order to prevent qemu-ga from crashin=
g
>> and to send a response to the qemu-ga client accordingly.
>>
>=20
> ... add here (see=20
> https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_m=
essage):=20
>=20
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054

And per the BZ info, please also credit the reporter:

Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>

>=20
> Also add:
>=20
> Cc: qemu-stable@nongnu.org
>=20
>> Signed-off-by: Basil Salman <basil@daynix.com>
>> ---
>> =A0 qga/commands-win32.c | 8 +++++++-
>> =A0 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index 9c744d6405..b49920e201 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -343,7 +343,13 @@ GuestFileRead *qmp_guest_file_read(int64_t=20
>> handle, bool has_count,
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 fh =3D gfh->fh;
>> -=A0=A0=A0 buf =3D g_malloc0(count+1);
>> +=A0=A0=A0 buf =3D g_try_malloc0(count + 1);
>> +=A0=A0=A0 if (!buf) {
>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to alloc=
ate sufficient memory "
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "to complete the=
 requested service");
>> +=A0=A0=A0=A0=A0=A0=A0 return NULL;
>> +=A0=A0=A0 }
>=20
> Can you fix the equivalent problem in qga/commands-posix.c too please?
>=20
> Also use "PATCH-for-5.0" in the patch subject so we don't miss it for=20
> the next release.
>=20
> Thanks!
>=20
> Phil.
>=20
>> =A0=A0=A0=A0=A0 is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
>> =A0=A0=A0=A0=A0 if (!is_ok) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg_win32(errp, GetLastError(), "fail=
ed to read file");
>>


