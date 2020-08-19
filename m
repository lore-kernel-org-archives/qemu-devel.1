Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E747EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17F7206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3rEh5Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17F7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8MTj-0005cC-VB
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8MT9-0005CK-VD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:41:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8MT7-0002q7-K2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597837284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AUlkOVPZTz9rwhgWoymfNcSWFat+rwS25G8ayYhk8hA=;
 b=X3rEh5Ra8UYuuQ9zzdAl08X1dzCfntpLZ0HwlEWkTsY2/5aVktGm+A5NiSiDMkonSao/g6
 EkNd2ClJJCXx1YXIF4S8Bf4XM2fp6QleKG5q0vZDbLIUcEesgf61Sd934tctW+2JcWur5F
 8EGFef9pRedV39i1jB/c6SWkjRRGIGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-QCsH68JSMkeQt4ywJqfaIA-1; Wed, 19 Aug 2020 07:41:22 -0400
X-MC-Unique: QCsH68JSMkeQt4ywJqfaIA-1
Received: by mail-wm1-f72.google.com with SMTP id t26so836342wmn.4
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 04:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AUlkOVPZTz9rwhgWoymfNcSWFat+rwS25G8ayYhk8hA=;
 b=mSxLSmehTOKHt5qZH5eU6aq/NNSX1hmyg0hCuG2MEDkn9gQqElm9vw9WrQarKTfcV8
 dayOXw7XAqW1+VdMUsTdVUnWAT/vFVxy666ZHBNxTqSDeQdQ9XJi6fZtlT4sLx9JyoEU
 IrnZNnrJT6/vTDug3ZSRCnSjVEVuQoS/+FLRV6iYG7gxM+0lEtTuCjc72t3fwmHKrlt+
 rIS4gjd6MTn2J2olhscOKPJRAc9xfjcq91oOaS+ko4DM1wEAXVpKHCogQoTT40Z8copt
 f0rqynsg4f4vW2gWwkSCZ7GylNHT6OvfFIYmF/XgqvuY8Dv7Dw/K2AEtWh0AU2H4X2GM
 Sn5w==
X-Gm-Message-State: AOAM531rVwnX4NCZHmmPib9n3VR9jk3udOSwyn/yCjZlHTcjmozooA1i
 Aecuca646gdx5pDLnMC0ly+K1A/fVymJX+hE7ExVVWvf7Zt0sUoTeBcXWY05mRj1lGcUGWhEE7M
 1aqXBfE88WGRXwJ4=
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr4347779wmh.37.1597837281747; 
 Wed, 19 Aug 2020 04:41:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvzYu7y/ukjd1Odp/tY5ar/DFiai6fsSYn0cl6W+haaGIxUC6FLCzVlU2X5S3VfsmI4v3Z8w==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr4347759wmh.37.1597837281447; 
 Wed, 19 Aug 2020 04:41:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id o2sm37934358wrj.21.2020.08.19.04.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 04:41:21 -0700 (PDT)
Subject: Re: [PATCH] tests: docker: support mxe-based mingw builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200819080206.27423-1-pbonzini@redhat.com>
 <20200819082013.GB69261@redhat.com>
 <a83d1d0d-3f5e-8aa1-801a-aaf844c29587@redhat.com>
 <20200819110954.GG69261@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b353e603-0301-8394-e7bd-4e75b93c87ff@redhat.com>
Date: Wed, 19 Aug 2020 13:41:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200819110954.GG69261@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/20 13:09, Daniel P. Berrangé wrote:
> On Wed, Aug 19, 2020 at 12:42:44PM +0200, Paolo Bonzini wrote:
>> On 19/08/20 10:20, Daniel P. Berrangé wrote:
>>> We already have docker containers with MXE based on Debian:
>>>
>>>   debian-win32-cross.docker
>>>   debian-win64-cross.docker
>>>
>>> your image uses a different naming convention, and puts both
>>> 32 and 64 bit in the same image.
>>
>> Yeah, that's what test-mingw expects.
> 
> Ah, I missed that.
> 
>>
>>> I feel like we should have the Ubuntu variant follow the same
>>> structure and naming as the Debian variant for consistency.
>>
>> My patch follows the Fedora variant, so that test-mingw runs.  That
>> ensures that NSIS is covered as well.  One possibility could be:
>>
>> - create fedora-win*-cross dockerfiles
> 
> Yeah, I think that'd make sense, as it'd enable a simple trick we
> do in libvirt.
> 
> In all the dockerfile recipe we set an env
> 
>   ENV MESON_OPTS "--cross-file=/usr/share/mingw/toolchain-mingw32.meson"
> 
> And in other linux-cross builds, we do similar
> 
>   ENV MESON_OPTS "--cross-file=i686-linux-gnu"

Yeah, that's the same as QEMU's QEMU_CONFIGURE_OPTS.

>> - add ENV FEATURES $FEATURES mingw to the win*-cross dockerfiles
>>
>> - look for the feature in test-full and test-quick, and run "make
>> installer" if so.
> 
> I'd suggest that "make installer" should be a part of "make" not
> a separate thing that needs running manually.
> 
> eg if we're configure'ing for mingw, configure should check whether
> we have the NSIS tools available and if so, then enable NSIS as a
> standard build output. We could have a configure option to enable/disable
> NSIS explicitly.
> 
> This  eliminates the second bit of special casing for mingw

Yeah, that might be an idea.  I'm not sure if it would work however
because "make installer" invokes "make install", so there could be
recursive (and non-reentrant) invocations.

Paolo


