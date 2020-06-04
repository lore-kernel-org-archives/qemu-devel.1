Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A3BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2BF206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNb/6+9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2BF206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgvF9-0005g6-IK
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgvEa-0005Fw-Ra
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:09:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgvEZ-00073d-S7
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 15:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591297738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dM/eaubxFUaTfCtZHcKChwRZS5cwfJojlmybvAvFX2A=;
 b=VNb/6+9CSXRok9S4bd+SvSwYH3MaWdjqpIO4Qmqpp8PSS8amwPPfn0lTRuqzijks/GIanz
 0wtel3oQTWys4CzImNG3bMVl0biUDArwGGFVqABTzxUbl8DQ6vRvm5dL/i0nPJEB2QD9RE
 SJ64fihTureOZ5DCRGcptjAWoUyjj14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-dc3h9yWiMRWXGK9AhBfMUw-1; Thu, 04 Jun 2020 15:08:57 -0400
X-MC-Unique: dc3h9yWiMRWXGK9AhBfMUw-1
Received: by mail-wm1-f70.google.com with SMTP id y202so2075680wmd.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 12:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dM/eaubxFUaTfCtZHcKChwRZS5cwfJojlmybvAvFX2A=;
 b=OI04mR+UUCcBkrsPYz0fWbr5qObJR7K5p62rgqc+/0hW5uNnSS5E757WcwLv5/8P+y
 D2LAX97tj8PmMOMMwTxlB/bP5pv1zTTI336gG2X9adr/aSvK2MAVDx9EPAYMjlujHlaq
 P5i1w8ku/HxxFb4HlojXvnKYEZEelR3tKlw1SlyKO0fnG8Yxw2rYX+Xm1L6m6hDfjq9O
 QuPmgttSRjA8Vash4QEfXBWwug02EZ1vniyHDSevK4McCY/RI4YA0qjr0RjA/RS65kUu
 c7KyVCitSIUaEz33MLI2yeDLA0ZmenEvvXcQJfUw8jmGqxPV4D5ZUO0j8iFhH3weLLto
 Sdgw==
X-Gm-Message-State: AOAM531Ia2Z9XofhamcghvfVXP8PTTaH7iCtsSVDhM/QV7I4zG9WVE+g
 kPnjuG6mGlX1y8j7giigE3xgXKlxv0cZx+Qkk6UEWaCmUewHzQ2QLpKyRPxUnOjt4Kv3RYegHvA
 AWnxY8X2D3j3zwUM=
X-Received: by 2002:adf:dd46:: with SMTP id u6mr5468315wrm.44.1591297736169;
 Thu, 04 Jun 2020 12:08:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrpZKnz08mTgtVYgpc679kjW19TO852ZW6gSOv+/no1UUQE90ZNf3wPF726JpJEEgMmWbeAA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr5468300wrm.44.1591297735961;
 Thu, 04 Jun 2020 12:08:55 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 1sm8439774wmz.13.2020.06.04.12.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 12:08:55 -0700 (PDT)
Date: Thu, 4 Jun 2020 15:08:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] checkpatch: reversed logic with acpi test checks
Message-ID: <20200604150734-mutt-send-email-mst@kernel.org>
References: <20200602053614.54745-1-mst@redhat.com>
 <b03eaa8c-fb1d-523a-6e41-c1d4ceaafd53@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b03eaa8c-fb1d-523a-6e41-c1d4ceaafd53@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 08:45:15PM +0200, Paolo Bonzini wrote:
> On 02/06/20 07:36, Michael S. Tsirkin wrote:
> > Logic reversed: allowed list should just be ignored. Instead we
> > only take that into account :(
> > 
> > Fixes: e11b06a880ca ("checkpatch: ignore allowed diff list")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 0ba213e9f2..55aa45dc16 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1267,7 +1267,7 @@ sub checkfilename {
> >          # files and when changing tests.
> >  	if ($name =~ m#^tests/data/acpi/# and not $name =~ m#^\.sh$#) {
> >  		$$acpi_testexpected = $name;
> > -	} elsif ($name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
> > +	} elsif (not $name =~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
> >  		$$acpi_nontestexpected = $name;
> >  	}
> >  	if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
> > 
> 
> Queued with "!~" to achieve the logical not.
> 
> Paolo

Hmm perl manual says "not" is the logical not. Weird.
What's !~? My perl is a bit rusty :)


