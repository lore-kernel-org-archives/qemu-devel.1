Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B70FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F6120776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGx5c0G6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F6120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegRM-0001bj-KP
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jegQn-00014L-P8
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:56:21 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jegQm-0005hz-JT
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:56:21 -0400
Received: by mail-lf1-x142.google.com with SMTP id 202so1477226lfe.5
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SrYgKgg5IMA5wlJ63/M4ZyK3UxZOc5JRa6Pu4vAWPgY=;
 b=xGx5c0G66Jj9wVZeS3+GRfgooAj1f4OyTOzosbmApTzKiN0NktTb9pNiVKRwd5Lqml
 eMtcnCdVpwvXNeAg8lzYkeym5zLuECgF0I7pR6rJzIpI48Wo478xxMqObR1lWKM8yT3x
 CjOhKhhUDHtFxyTuHToUqMZxzKjNFMO02Q7flVaCgADe3JloRsKUJqAGnbKV2mJxLnxa
 doTX3bIvPinOosCR+nLh+TkBrHJBrSk+uRDpDhUMs/lz5BHE6fAeomjvoBN5wQsCu6zf
 Up7Pzrs0BR4sHC5MTIOTGcihAfWBdcyx4QuvpBu/l2WFvxhIBh0OI3YbacIf3Bj4/6+t
 JTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrYgKgg5IMA5wlJ63/M4ZyK3UxZOc5JRa6Pu4vAWPgY=;
 b=rmXfLr+7uAMqC93Neh3JlM06817QoEmGdeF1kiiIktwFXF5dEBJCq9RZ/8LfvXMS6e
 Z+1FULq/gEjDGHqIR34izFAUBdOOrxBGo7eT1OeQhI2CZEirHSCM+MKOebrblIMknuZ4
 xSgzp9YgpuwQs/6e2SLzmcM3Q2TX0b1siK/PlMwogv/kzAM0c1dsUArnzMM51W+aMyJH
 aStaPoRF+jg7hA+baEqbwOKse2jhayoIKb57FUWiais0WWW9qa52rMsCRDFSCJ3DdU0e
 IfqVmg9YpQCOmnpWsD80TUbEuuU0cpJI5A6Iwz9vTygrDkLGJNzyFHzRhSNbtQx3Kdew
 j8TQ==
X-Gm-Message-State: AOAM532il3ugybXjxb1B7aqs+lY9c43OXbXKjSeOnBYKAljiDLUeV1HX
 ZB1EE43dkt2wI8wGr7al/3RL7HMLEyCibsBYQCrQuw==
X-Google-Smtp-Source: ABdhPJw2VDdllF1iVGvkc64sU0emfxyg+Q/21CmgBfv0ZatbGwaQHL1oEAvtIuPM4DL795EDoCrTHXWSUa4r3O1aGrY=
X-Received: by 2002:a19:6554:: with SMTP id c20mr4555940lfj.140.1590764178411; 
 Fri, 29 May 2020 07:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200529132341.755-1-robert.foley@linaro.org>
 <ee86aad8-5a22-5d5d-54f2-f0cb15c7a8b5@redhat.com>
In-Reply-To: <ee86aad8-5a22-5d5d-54f2-f0cb15c7a8b5@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 29 May 2020 10:56:14 -0400
Message-ID: <CAEyhzFvOjMmPv2S3i1_jA6oqXJAgAM-COG6sBucfVFd6FjPqfA@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Lingfeng Yang <lfy@google.com>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 at 09:51, Eric Blake <eblake@redhat.com> wrote:
>
> On 5/29/20 8:23 AM, Robert Foley wrote:
> > From: Lingfeng Yang <lfy@google.com>
> >
> > We tried running QEMU under tsan in 2016, but tsan's lack of support for
> > longjmp-based fibers was a blocker:
> >    https://groups.google.com/forum/#!topic/thread-sanitizer/se0YuzfWazw
>
> [meta-comment]
>
> This message lacked References: and In-Reply-To: headers, making it the
> start of a new thread for patches 1-11.  But I also see you sent a 0/12
> message with Message-Id: <20200529132143.702-1-robert.foley@linaro.org>,
> as well as an unthreaded 12/12 with Message-Id:
> <20200529132438.837-1-robert.foley@linaro.org>.  You may want to figure
> out why your sending workflow is not preserving desired threading.

Thanks for pointing this out.  I see what happened here and will fix
it for next time.

Thanks,
-Rob
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

