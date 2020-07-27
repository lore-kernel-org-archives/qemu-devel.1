Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E7C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2D52074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPXipP3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2D52074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0360-0002bQ-Dz
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0358-00021m-Ra
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:22:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k0357-0006MW-AM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595856136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUQB4tpRp+4qJdSr6XrP8pxvz9rSAPts+mXUPB0rTkk=;
 b=NPXipP3k/z8tjRcXmiuh9lMPoEckJ6wivY8sQ96xFJaJ8b4yJqSRn9obUC9eIIX5Wdcl6p
 4tdX7OoziNg8OtBNBKJcgka2vfrRdTXgyo6noFevDduXbzR2GDX0e4KiIsfuhqKZg0SaSf
 hjk3aa7QdVeeq6EA3HXhKQpnaxVp0wY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-bEMz7XTPP-6elDE1Ln4xrQ-1; Mon, 27 Jul 2020 09:22:12 -0400
X-MC-Unique: bEMz7XTPP-6elDE1Ln4xrQ-1
Received: by mail-wr1-f69.google.com with SMTP id 89so3931229wrr.15
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NUQB4tpRp+4qJdSr6XrP8pxvz9rSAPts+mXUPB0rTkk=;
 b=myjcvmD8b0/53Z/dcQO/Br0oXwvoJYy98yHdEbD9X5SzmkUBxzbNAQr4YB0ftRLoMV
 TC3KgYBzUWQWNNuqC7GtYdlsgobCQckVkmf2bPFOnFRZNMdk5gzfDoJntEfC0XXMeKDM
 FS1nqHduO+qcH/4h0tZWB6zVRLci9/f/h8VxziI6hqCVUGT3W2gNDPzixeLUkUGtOq/D
 1Kjp7Ru0BhEuibvmj4xw6vBH3PoyLm/jhXLhZwteiV4pDg1BRgRdxBtjRl7R6G2OnRPK
 stdV82Di7NYKr0fFQU8C0RhyH5jblKexZ6TD0h+/AuLMNwhHcElnYrBM0/ykWeD5VAHK
 Vq1Q==
X-Gm-Message-State: AOAM532FYELuXmnVYCIgyyaO0fGqdH7y43wx/maeqmNZh8CfKqNcfdyn
 ygEz0fkydgTQL3cvpecOhN6tdNs1BbLlSwn1qPehRDhlKgVUYznT27y+/vsAccSls3xUSnLnz4M
 F+eQVlfdzf2b8mzo=
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr19880196wrp.268.1595856131472; 
 Mon, 27 Jul 2020 06:22:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKzz85sI5UnIXc17wUUbmVW4T6ErO9y9RHYBuEVNrwQWDNgLDeKh5uap+T+cFH+1YbDmAFzg==
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr19880184wrp.268.1595856131304; 
 Mon, 27 Jul 2020 06:22:11 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id v67sm9169007wma.46.2020.07.27.06.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:22:10 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:22:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v7 12/21] multi-process: Connect Proxy Object with device
 in the remote process
Message-ID: <20200727092043-mutt-send-email-mst@kernel.org>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <20f42fce1b701586a23c9abdb3b53d080845e94a.1593273671.git.elena.ufimtseva@oracle.com>
 <20200701092043.GE126613@stefanha-x1.localdomain>
 <BE91B4AA-7E18-47CE-8747-97152D6462CC@oracle.com>
 <20200727131829.GD386429@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200727131829.GD386429@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 swapnil.ingle@nutanix.com, John G Johnson <john.g.johnson@oracle.com>,
 qemu-devel@nongnu.org, kraxel@redhat.com, Jag Raman <jag.raman@oracle.com>,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 02:18:29PM +0100, Stefan Hajnoczi wrote:
> I suggest dropping multi-device support for now. It will be implemented
> differently with VFIO-over-socket anyway, so it's not worth investing
> much time into.

I'm not sure I buy the VFIO-over-socket yet. It seems a weirdly QEMU
specific IPC mechanism. However ...

> The main socket approach needs authentication support if multiple guests
> share a remote device emulation process. Otherwise guest A can access
> guest B's devices.
> 
> It's simpler if each device has a separate UNIX domain socket. It is not
> necessary to modify lsi53c895a in order to do this. Either the socket
> can be associated with the remote PCIe port (although I think the
> current code implements the older PCI Local Bus instead of PCIe) or a
> separate -object mpqlink,device=lsi1,fd=4 object can be defined (I think
> that's the syntax I've shared in the past).
> 
> For now though, just using the -machine remote,fd=4 approach is fine -
> but limited to 1 device.
> 
> Stefan

I agree to all of the above. Starting with a single fd is a good idea.

-- 
MST



