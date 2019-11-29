Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAF1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CF1208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9ghvOZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CF1208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadzs-0001RM-2v
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iadmv-0001Ul-Ua
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iadmr-0006pV-Q6
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:46:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iadmr-0006j3-LN
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575024368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NZ7tsGoEcvwYPOdPUoIOaZuhKZxcAY4kXCTjG1/WP0=;
 b=N9ghvOZ+mx1TXurj2jfJJNMMjizLyDFzXwanTQrxrf5wquX4f36A1gU2UnsZLhvb8cz0yB
 cmNXy/kPZzsPdFPPRs1Um6m/AGzwKR8Wg+axXJ4H2ACWcoIFFTfhz0nTSG+d/8RCH5apbr
 A6CwrltihcgylV2p+vfdLUI6SNfV++g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-V3ERHxMzMDCUyZ73g3guyA-1; Fri, 29 Nov 2019 05:46:06 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so2660326wrm.23
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 02:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qFjvnKQPOc3zQHdLbmBLqe8cziZfg/I4FicH9ONQsRA=;
 b=K8Mfi7mp0YLpZ6A7MnVEk9NgBjPM1LNaWm3eOxEjf6J7nRIRHpCi9Pmn61DiZcLcDg
 TetIH4mmoS+xT53DNGOUWQL/G2NfXJjSVTm9AoTRqFngh+tGsRtk115dF40+V36uHIz8
 9VvUH68ixUF4050K8qC7Mj6F6ImNnWa8C2NHNofY1QTuRcdXvoSBjlFR23Hc2ismTqmt
 jhK0dJKDcM+ahUAHaHccWqghSwn8RPK8etD6Iy1qrwOmRZM+lIl2zWcGtWMxAuEu/juJ
 mPqGI0maorRDxgNnMLN/bfqBdnKdINk0rSJWzVl0OGIwwai5K4zGSUdQBM2q0g/5R8uI
 h/Xw==
X-Gm-Message-State: APjAAAXQawixOmOI8sjFIiRwNH1biZRKh9R/pvitGSf3fujuioK1IiI4
 Mep9XYlMVqnrF3FSEhBaSfdXhtC3c/QFYXdYB45GHPm9+Pvf4+07QqeQ9mLfgl6TnoFHZRUUbFr
 L7Ra+93bydpAF9Og=
X-Received: by 2002:a1c:1dd3:: with SMTP id d202mr6853089wmd.130.1575024364826; 
 Fri, 29 Nov 2019 02:46:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBAEaGfDTB9s6pd0KYMIoVEr16l9hZk2gl4v+EJrtbCpkon3KXQuXWVYsAfrLjceU9KQXtjA==
X-Received: by 2002:a1c:1dd3:: with SMTP id d202mr6853053wmd.130.1575024364528; 
 Fri, 29 Nov 2019 02:46:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id w11sm29086080wra.83.2019.11.29.02.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 02:46:03 -0800 (PST)
Subject: Re: libcap vs libcap-ng mess
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
Date: Fri, 29 Nov 2019 11:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129093409.GB2260471@redhat.com>
Content-Language: en-US
X-MC-Unique: V3ERHxMzMDCUyZ73g3guyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 10:34, Daniel P. Berrang=C3=A9 wrote:
>>   y) Should we flip over to only using one or the other - what
>>      are the advantages?
> In libvirt we use libcap-ng. We picked this originally as its API
> design allows you do write simpler code than libcap in some cases
> You can see some docs & examples here:
>=20
>   https://people.redhat.com/sgrubb/libcap-ng/
>=20
> So I vote for changing the 9p code to use libcap-ng.

It's not entirely trivial because fsdev-proxy-helper wants to keep the
effective set and clear the permitted set; in libcap-ng you can only
apply both sets at once, and you cannot choose only one of them in
capng_clear/capng_get_caps_process.  But it's doable, I'll take a look.

In the meanwhile, if someone else wants to look at the CI I would
appreciate that.

Paolo


