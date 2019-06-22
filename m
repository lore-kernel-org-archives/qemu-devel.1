Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4F5C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 16:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6A820665
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 16:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldsJyRj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6A820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heiRr-0004Tk-Nd
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 12:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1heiPW-0003vK-Ps
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1heiPV-0003Jh-Nz
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:58:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1heiPV-0003It-GO
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:58:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id i4so9457274otk.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2019 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=imCTxdPEt5J++AIJaO2+JaMor4MuSWehoKKHw0VfX4A=;
 b=ldsJyRj2+fKmIGTN/FepHU07GBewmcV4938R+cDf6IP9HCBBxCWoMjYXbIqn9aR3OO
 VuWPkX3NYZ67BaKdAsut5AQ1odEEfxNk1fFYGa3Dm/tsyBoxCs43+qGoAsism/6mdoJp
 Ulcp1MxrdYRoFej7XJlOoOiNEL9lencHDWvjUtM5YOCzrOEPkvD2cZXMKFD+kR5eFQ1u
 ixk+393vFHiZWAWW17eTbG9S/tKXbT+v6o4TcNLbx5HsBpfuigZeeMCcRGntCGh1xwWs
 QtMbupFv+ocIkyGppjKyKaHDMkhG0L3GkK+GZBDL60GDK/ikuqCEJpI7NB5Ph72M8X7I
 ipKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=imCTxdPEt5J++AIJaO2+JaMor4MuSWehoKKHw0VfX4A=;
 b=RKyjDUOzFqTQUPDzOOLsMDLATOhygud0GbLnX+tQgzn4nkm4mgJMbDnLOATJVFMswW
 ltDRRmEwEhtDvuzqVL9ydsK1gNT9aSzTfZ2dTAjVmydwBeiZoXD/egWqwQa8sLGnLVQ/
 neHR9jTFXV/QPp3Fcftq+fQyzwn9I3vztdyqMxIkZCKSJhcNd5ghpkUGa5OoTlFISnYZ
 ixUt/tng193hZz/b8iwVq537pNDxU8qYULWuW1kObiFRQoJeY9N72+1h0/bJMbQG28Y1
 EmOrtSzKd0mbb2FdegsNJuK/dMzMaqg7CWMPWxj5Y34lNB3jqQSGZbLtxe8/4eQ9Uero
 HMOg==
X-Gm-Message-State: APjAAAX3UVTavAsJ86WuGwEF/JmhS3qz4ixalPri36pddb0fixW/O4v+
 MsvtR+h8TxdHZKZMn7RAhSf8hDNmzbhwagGEGRFggQ==
X-Google-Smtp-Source: APXvYqyCNJuXJmpa0eiHmJA3xKlUOFGv7El3pLDyf8V37yVbDNpyO8K8z89iUCyu8gCryNVlnRMnGOqmv1mJUHValMI=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr22171787otj.97.1561219116481; 
 Sat, 22 Jun 2019 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190620222314.2670-1-wainersm@redhat.com>
 <CAFEAcA92m9n7FR2a6=ecnr5bn-Sq97LZRxHRuzWO-OcbdgA4fw@mail.gmail.com>
 <20190621190421.GA679@localhost.localdomain>
In-Reply-To: <20190621190421.GA679@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Jun 2019 16:58:25 +0100
Message-ID: <CAFEAcA-x_GSxiULrxvRj7dtCLM-r4YvRpwkVosW+1SutAUJMoA@mail.gmail.com>
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [RFC v2 PATCH] hw/arm/virt: makes virt a default
 machine type
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Jun 2019 at 20:04, Cleber Rosa <crosa@redhat.com> wrote:
> The experience acquired here deserves the highest consideration, but I
> can't help myself to wonder if this isn't one of the (conceptual)
> reasons for parameters such as '-nodefaults'.  I know QEMU doesn't
> promise the same behavior across different targets, but that could
> improve considerably with very cheap actions.

Yeah, there are probably improvements we could make. The
usual constraints apply:
 * we don't want to break compatibility with existing used
   command lines in the wild
 * ideally, we should be consistent across target architectures
   and across machine types about how things work (this is
   an ideal we obviously don't live up to today in many places)
 * we don't want to back ourselves into awkward corners for
   the future (the qemu-system-arm default machine type was
   originally 'integratorcp' which no doubt made sense in 1998
   or whenever it was, but was nothing but confusing and the
   wrong choice for 99% of users by a decade or so later.
   x86 is kind of an outlier for having such longevity of "all
   hardware looks basically the same".)

> You can consider me biased (I do consider myself), but trying to wear
> the hat of a user first interacting with QEMU, I would expect a (any)
> reasonably capable environment that can represent the given target.
> That will probably be a different environment than the one I may need,
> and I think that's fine.

I'm really not sure what you're trying to suggest here; maybe
you could clarify? If you specify a target (ie a machine type),
you get that machine type. If you don't specify a target, then
we can't really guess what you were hoping to run and
magically pick something that works.

The main problem here is that users expect "all the world is a PC"
type behaviour, ie they can just provide qemu-system-arm or
qemu-system-aarch64 with no command line arguments except
a guest kernel (which is half the time something they found under
a rock or extracted from some firmware image) or a guest CDROM
image and have it boot, because that generally works for x86. It
doesn't and can't work for Arm, because of the much greater
diversity of machine types and the way that kernels are often
only compiled to work on a specific subset of machines.
Making the user specify a machine type means they do at least
get prompted that the world is more complicated than they
think it is and there are decisions that have to be made.

In any case even if we did default to "virt" the user still
has to specify a CPU type, may well also want to provide
a GIC version (gicv3 being better than the default v2),
likely more RAM than the very small default, they need to provide
all the virtio devices, and so on and so on. So giving
them one option they no longer need to specify doesn't
really make it any easier IMHO.

thanks
-- PMM

