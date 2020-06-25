Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DE6206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UigVSVBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DE6206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOc8-0001r6-Lh
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1joOad-0000Zz-BG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:54:39 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1joOab-00086S-Ko
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:54:39 -0400
Received: by mail-lj1-x242.google.com with SMTP id n24so5780674lji.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=i5C/Vk5xtR3jNOfZCItvI1cKfxesEALRkKpY703ZjaA=;
 b=UigVSVBh4S4j0muvHsV7SEmyOB0MdOiOO7bgM8f9Ko0hEo/eaL9IvL1VUfN4OBEs68
 15X2gg7sGw5r0rk2hbvZ5xhVt2t1cwEQYwSbKEOSvrSbJkkz5ZqpgwjsoKcVwraRoLHU
 2InlCRD3VwYuS4OXX3q1qFZWqmGA34geGO9qXtcDkIKNelRf+X4fEz+NxASMw99rIUZr
 ksW/NVt4nxfvUatHlns1S808ZOsUQZhNzRMzoau6KndLKZ+t4ax5I+6Rvgt/FUf/yT30
 Ww/lrqlBfdtruHo+/tvP3xgAm8gphLYcEOsBGFh4NoAjkIdO8VabkMUddXgJdseihHua
 IwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=i5C/Vk5xtR3jNOfZCItvI1cKfxesEALRkKpY703ZjaA=;
 b=MjlliD9ndYMw4abAiWnCEBDQBudDdBLCZKVBo8A/HLYkqyi501wNGqA970O58UVx/Q
 eww4fdAFN8lg+evztoAqsTAeL5uG3U+Ky+1l2mkU9oLqMyQWZtfrsrUIq34hcp7ayPnY
 IJSSd0h3G4hfDi8gsC/u3eR+CISGNMSbV3HH+PRjn7cVJOCmVT+pXWsV1/LolngedsKP
 dQCCWKFZhimM5CkPlb6RFmXgQFX1EJYuSJfa2PF9nz83YHmXx0jZRwRvbzfcAFEoO5CY
 VJK5zLexapiII/Ca7gie9p4IG0aZ6Nt23Vog+nSSs3Zj5WSo5IEclDqDrrxFmwQ2PR/v
 iCVA==
X-Gm-Message-State: AOAM533xXD+tdyQSEiZljJzMVdLCectZFw7bkPZ3p0S6wf7fQMOal5bn
 vsLQRAZgRKbqLAIvOf50agc=
X-Google-Smtp-Source: ABdhPJxG1yQT9WlkADb0ht1F5v6QWSsb8ylTI8wi1e/ugF4AdHV0CgpCnEb+L+TefiufaRaWhHGw+w==
X-Received: by 2002:a2e:8002:: with SMTP id j2mr16311255ljg.158.1593078875789; 
 Thu, 25 Jun 2020 02:54:35 -0700 (PDT)
Received: from aorus (193-239-39-51.ksi-system.net. [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id f129sm5843805lfd.6.2020.06.25.02.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 02:54:35 -0700 (PDT)
Date: Thu, 25 Jun 2020 11:54:33 +0200
From: Szymon Lukasz <noh4hss@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/6] virtio-console: notify about the terminal size
Message-ID: <20200625095433.GB118320@aorus>
References: <20200624112640.82673-1-noh4hss@gmail.com>
 <20200624115615.GI774096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624115615.GI774096@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=noh4hss@gmail.com; helo=mail-lj1-x242.google.com
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

On Wed, Jun 24, 2020 at 12:56:15PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 24, 2020 at 01:26:34PM +0200, Szymon Lukasz wrote:
> > In this series resize notifications are only supported for the stdio
> > backend but I think it should be easy to add support for the vc backend.
> > Support for tty/serial backends is complicated by the fact that there is
> > no clean way to detect resizes of the underlying terminal.
> 
> In a libvirt managed scenario it is typical to have the virtio console
> connected to a UNIX socket. It would be desirable to have a way to
> deal with resizes there.
> 
> QEMU socket chardev (TCP & UNIX socket) supports a "telnet" protocol
> addition. Currently it doesn't almost nothing useful, but in theory
> we could wire up support for the telnet resize message:
> 
>    https://tools.ietf.org/html/rfc1073
> 
> 
> Another option is to allow dealing with resizes out of band, via the
> QMP monitor. ie we can introduce a qmp_chardev_winsize command that
> a client app can use to trigger the resize message to the guest OS.
> From libvirt's POV, this would be quite easy to support & useful to
> have.

I will look into that.
> 
> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

