Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48620C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13756206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t16UoUoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13756206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOYw-0008ED-DB
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1joOYM-0007gM-Dt
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:52:19 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1joOYK-0007fm-H8
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:52:18 -0400
Received: by mail-lf1-x142.google.com with SMTP id k15so2869101lfc.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=TLAt0JzHjWyfa19HHiEjXlQXqMsnEA/HhNwSSx9/fpg=;
 b=t16UoUojRfSef34Tw4mCgIEBoa9IB+RYNqNbo5XUAO0caJjT8CF+zxLi/cHfFAzCyd
 V/cZokZ+/Qauhb2Rdnid9a9xDC8UsQuGQ8BeGX+ONbnjIYBUqfVPuMtUdZ6G9l1OJZEn
 l9qy7++p/WCsUWdeqohKcKhUb0uFnoHnr2itPXu4LARpz50VTjK7a8Lfd4qEObNiRGaZ
 g4J3UPKWgyXq0In9hsGzxJtrggQV/n9dISEO4e/d279CTLykvWGwljpIbBNvt6QQw79n
 CrUJRONJnPnZG75R0SZUbRL9cBX6z4co5CiSjslBm+fZdKGvF4k4Y/YLjdxGzmvRxEqK
 vNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=TLAt0JzHjWyfa19HHiEjXlQXqMsnEA/HhNwSSx9/fpg=;
 b=WenyjucNU08Ik23+rmFZGfmrUqlnDrZrd3jLQgpv+qs4TBfR0ItWa+uleTQD7epFp9
 G/wui9Z4zF6trpfUQJzswyUbvoi9Jz9YD+ZCFEtmm81Zo9uSRuppHWoQSYTxBoWV67Kd
 3mlK7vRr8kC+YdZPwiKa5xK9l5XR5dbsaV/jBfSxSbl7wed3DimqKHP3sztiJRjiAFx6
 MUT5Bc3Qg4MEnGX/BIiHVp9O+em/VG3Kkiuj/AOfXl42tjEL1mN2bDWbRWtZ7PsK+yKx
 L6XNUlJSjerdp7N2Fzxg6j8Xs167B+0NQsHs6oHt8FLT0V28QBjX5JKoZ3i2a9syfHSB
 fO5Q==
X-Gm-Message-State: AOAM532ktsn7HOv3CDC+qjNUisHujCeHaIBwxMmkBBmZgoiXEqlSEN2p
 frMxBAL8cCw2mlIXZpZ//1A=
X-Google-Smtp-Source: ABdhPJyLalw1EiVZ3hEMQduHLQ0kn6fo5HLsdNqRhHc7lhsLvhwQBVTBhQjamGhX5EL+0Imtoirh+w==
X-Received: by 2002:a19:cc93:: with SMTP id c141mr2789068lfg.15.1593078734668; 
 Thu, 25 Jun 2020 02:52:14 -0700 (PDT)
Received: from aorus (193-239-39-51.ksi-system.net. [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id v22sm4722011ljg.12.2020.06.25.02.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 02:52:14 -0700 (PDT)
Date: Thu, 25 Jun 2020 11:52:08 +0200
From: Szymon Lukasz <noh4hss@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/6] virtio-console: notify about the terminal size
Message-ID: <20200625095208.GA118320@aorus>
References: <20200624112640.82673-1-noh4hss@gmail.com>
 <20200624114915.GH774096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624114915.GH774096@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=noh4hss@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: lvivier@redhat.com, mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 12:49:15PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 24, 2020 at 01:26:34PM +0200, Szymon Lukasz wrote:
> > Also there is a problem with the virtio spec and Linux Kernel
> > implementation, the order of fields in virtio_console_resize struct
> > differs between the kernel and the spec. I do not know if there is any
> > implementation of the virtio-console driver that handles resize messages
> > and uses a different order than Linux.
> 
> Well this is a bit of a mess :-(
> 
> The main virtio_console_config struct has cols, then rows.
> 
> The Linux impl of resizing appears to have arrived in 2010, and created
> a new struct with rows, then cols.
> 
> commit 8345adbf96fc1bde7d9846aadbe5af9b2ae90882
> Author: Amit Shah <amit.shah@redhat.com>
> Date:   Thu May 6 02:05:09 2010 +0530
> 
>     virtio: console: Accept console size along with resize control message
>     
>     The VIRTIO_CONSOLE_RESIZE control message sent to us by the host now
>     contains the new {rows, cols} values for the console. This ensures each
>     console port gets its own size, and we don't depend on the config-space
>     rows and cols values at all now.
>     
>     Signed-off-by: Amit Shah <amit.shah@redhat.com>
>     CC: Christian Borntraeger <borntraeger@de.ibm.com>
>     CC: linuxppc-dev@ozlabs.org
>     CC: Kusanagi Kouichi <slash@ac.auone-net.jp>
>     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> 
> The virtio spec documenting this came 4 years later in 2014 and documented
> the resize struct with cols, then rows, which differs from Linux impl,
> but matches ordering of the main virtio_console_config:
> 
> commit 908cfaa782e950d6656d947599d7a6c9fb16cad1
> Author: rusty <rusty@0c8fb4dd-22a2-4bb5-bc14-6c75a5f43652>
> Date:   Wed Feb 12 03:15:57 2014 +0000
> 
>     Feedback #6: Applied
>     
>     As per minutes:
>             https://lists.oasis-open.org/archives/virtio/201402/msg00121.html
>     
>     Signed-off-by: Rusty Russell <rusty@au1.ibm.com>
>     
>     git-svn-id: https://tools.oasis-open.org/version-control/svn/virtio@237 0c8fb4dd-22a2-4bb5-bc14-6c75a5f43652
> 
> I can understand why it is desirable for the resize struct to match
> the order of the initial config struct.  I'm guessing it just wasn't
> realized that the Linux impl was inverted for resize
> 
> The FreeBSD impl of virtio-console doesn't do resize:
> 
>   https://github.com/freebsd/freebsd/blob/master/sys/dev/virtio/console/virtio_console.c#L874
> 
> Not sure what other impls are going to be around, but I feel like
> Linux is going to be the most commonly deployed by orders of magnitude.
> 
> So I'd say QEMU should match Linux, and the spec should be fixed.

I had the same thoughts. I will ask for a change in the spec.
> 
> 
> Have you reported this bug to the virtio spec people directly yet ?
> 
> I don't see an issue open at
> 
>   https://github.com/oasis-tcs/virtio-spec/issues/
> 
> so I think one should be filed there
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

