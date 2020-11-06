Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E76C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 22:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32E4206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 22:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FO2v1mp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32E4206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbAcL-0001ZN-KF
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 17:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbAbh-000164-0R
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 17:53:21 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:35439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbAbf-0003n0-Dr
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 17:53:20 -0500
Received: by mail-ed1-x535.google.com with SMTP id ay21so2885406edb.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 14:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jtav6zTn2rJUp1XqNQIC72rB2aAcJZ0TsBMJAFNVvow=;
 b=FO2v1mp03qAtp9hZIjN2pYVoGNZxTvisI9NXNnQsLr2k/2rfer0a4RsxG16nf/rjqj
 eWTWQHCJOLHeq6NjwPD0NDyqo6ysVr1QWHZWTLGLQUKeDPv1LLos/PZ+ATN6AbeDNV10
 gIb4So0IngD6fQbYVGwK3DBf5p688USP4K9/yhMoCkpap1XPRt48pK8leTxSHphuutfK
 OVbFiSWhNWPS2a4WmrbrQu/5NLqYPW2aF7dGu9UIy3Vk3LwpYQWiZJa8ld/hfzwek6Bc
 ktu8mCVaulk46uXKY+5kQdSoJnaZ+1BswKIigMMTPsMkMpTNPb2mf+NUInFNGcii5Vsq
 coHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jtav6zTn2rJUp1XqNQIC72rB2aAcJZ0TsBMJAFNVvow=;
 b=g/sQcDr8O4M84GF+S3djZ/YEbsbvg7/VBJxFI5dWjnK9z33cTPe/4HoYnsSFxKGeT2
 ZxxWfUAua2qA5bcl4o3onoovSygKUoHVB2l7AAvMx+jedCpkDO+QpfCQsl3x18WQqmgG
 /MW9r70I2pUYuUZkN3lchNbgKivmwi15t/vXJPZorWuWqGn9eV0d14dfKjkWJ+0GNrkp
 z7T3fasOKi04RGMPoFJKFKCiCyQujN2E6EofEwvWfQ+0fE0gVagmDdPt+p6RCSlnubWq
 RpGNSSsWaylz1KVrKkGd8UeBZqy7v9gV4W85/VXHyZ4IpIuT2wiRtrbRym3laSAZgE96
 J2rQ==
X-Gm-Message-State: AOAM533IYo1a2xbJYaHh57FMLUEqWvGDVxgXRhWHq2asG35dW9o/ecsJ
 y2eZV+weItk87GfZzJOEkx7fn/Fb/30b5Dk7mpEnfA==
X-Google-Smtp-Source: ABdhPJzraX6hO/+1h4D/LC5mce7zDS9qOvT4JM6bslWfF03p+/Sc4TW6naaxym61ufuIOl0E7ytIScNcDIrdEMC3Me0=
X-Received: by 2002:a05:6402:30b5:: with SMTP id
 df21mr4398524edb.146.1604703196101; 
 Fri, 06 Nov 2020 14:53:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA8keTZEW3MLky3_HKh5cu2HR1O0iBax2c0hs0qSosNYSw@mail.gmail.com>
 <9ff386a7-c334-30ed-da79-341d75ed39b2@redhat.com>
In-Reply-To: <9ff386a7-c334-30ed-da79-341d75ed39b2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 22:53:04 +0000
Message-ID: <CAFEAcA8Po-V6+b-AVxSdwrEJ7Zy2Pm7xf8Ss4fsUtWDMG=ziQw@mail.gmail.com>
Subject: Re: nbd: bitmap_to_extents() calls nbd_extent_array_add() without
 checking return value: coverity false positive?
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 20:36, Eric Blake <eblake@redhat.com> wrote:
>
> On 11/6/20 11:22 AM, Peter Maydell wrote:
> > Hi; Coverity's "you usually check the return value of this function
> > but you didn't do that here" heuristic has fired on the code in
> > nbd/server.c:bitmap_to_extents() -- the function nbd_extent_array_add()
> > is called five times in server.c, and the return value is checked
> > in four of those, but not in the final call at the end of
> > bitmap_to_extents(). (CID 1436125.)
> >
> > Is this a false positive, or should the caller be handling an
> > error here ?
>
> False positive, but I don't mind tweaking the code to silence Coverity.
> This should do it; let me know if I should turn it into a formal patch.
>
> diff --git i/nbd/server.c w/nbd/server.c
> index d145e1a69083..377698a2ce85 100644
> --- i/nbd/server.c
> +++ w/nbd/server.c
> @@ -2128,9 +2128,8 @@ static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
>          }
>      }
>
> -    if (!full) {
> -        /* last non dirty extent */
> -        nbd_extent_array_add(es, end - start, 0);
> +    if (!full && nbd_extent_array_add(es, end - start, 0) < 0) {
> +        /* last non dirty extent, not a problem if array is now full */
>      }
>
>      bdrv_dirty_bitmap_unlock(bitmap);

Hmm; that looks a little odd but I guess it's a bit more
documentative of the intent. Up to you whether you want
to submit it as a patch or not I guess :-)

thanks
-- PMM

