Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25B9C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAA8208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flBUsmzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAA8208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgmx0-0006RL-Pj
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hgmw1-0005xA-BT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hgmvz-0001zB-DN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:12:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hgmvy-0001wN-NT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:12:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id f9so5429746wre.12
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9CxFWJAzhm4sw7xul7r9rN1W4U+nFU4qg2Suoge3uZA=;
 b=flBUsmzxzb0Hn5Fhh+/FofQ2nomleIkMA8UT7xO6FOOSFklyF4RMPYAZhPmPyB8a35
 FR2xyeTyqG9qwz4UDdYXxjTxQz0fkWaFGZiiBAXdsyhqysgsJL9wTR9k1SV5nPHLbnjb
 dnqaiti0kjd+rw1RAyv88JPuGXoFMiBoDtw2/n9nKNL3/42lSqvaIQg5E6TVtqDOCH7k
 EWnAdK3iM7wnIBleBPBmFU9hsucNMBBPwzpdJItSxCdbCNgqfT8PFPlNp59wNd6tG/fb
 qerUPTrehNjAMtNnaTvpr60SnstpNEOeWfbYohcSeQYfOdRhCmUI44hQ4xRZSkPCwYCZ
 N7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9CxFWJAzhm4sw7xul7r9rN1W4U+nFU4qg2Suoge3uZA=;
 b=NfUEbsJl39HMBvyG7abUiFbqLm8/jJJsxvAJ6jUXTWfYA8TgTkEhEeuk7WC0fCKZWi
 v+rKd3S6J+9g0tQAMDN0mSv7j5V7AouZpkLKUwD7sKftrpfExNdFJAqj4hwJX8vC2Pa0
 4r41777sZNFlrto2gZSlWDra/6mUjL2EB9MQbFhqx0ujnsdm9VDppUywUUTj8dcjgsFn
 cQAOp4DMA66U00lwdNG6bsoUmUEknpDPPDLkuksgWgNJv4nrcTQQeZPzJvN3j3p71XSz
 Ktmajh+R70Z/brklAQxlbZXGCtYEcUFQGo4+zbBzXUka/ZIN7HbD1etB8xw10wl7TC6i
 WGLQ==
X-Gm-Message-State: APjAAAVBqwIxrKFfioo/SdJyXLQN82REThEeXqG8CPjyGGbBmOXIMAXu
 aLFT/BGxordwteqYyH7DL6Q=
X-Google-Smtp-Source: APXvYqwC5R6/+4ty41A+sl+8W+hF8aQTj8fqIPx1/fNFrNJOa2JOXq/8WcJSjJkrKZ1vhnRVfF391Q==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr7072349wrv.104.1561713160586; 
 Fri, 28 Jun 2019 02:12:40 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l124sm1467022wmf.36.2019.06.28.02.12.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 02:12:39 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:12:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dimitris Karnikis <dkarnikis@gmail.com>
Message-ID: <20190628091238.GB3316@stefanha-x1.localdomain>
References: <24d54a82-bbda-4edb-3ccb-d3144d2daac7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <24d54a82-bbda-4edb-3ccb-d3144d2daac7@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] Mapping of the guests user and kernel pages to
 host memory
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 16, 2019 at 04:48:55PM +0300, Dimitris Karnikis wrote:
> I am interested in understanding on how QEMU maps the user and kernel
> pages of a guest OS to the host OS memory (working on 3.1.0 but any version
> is acceptable with target x86-64 arch).
> Since QEMU runs on user space, these pages will be also mapped on the user
> space of the host machine. So my question here is, where do the allocations
> take place, and in which place of the source code I could find the mapping.

The QEMU host userspace process allocates guest RAM or mmaps from a
given file (e.g. /dev/hugepages/).  QEMU keeps track of them using the
RAMBlock structure.

The guest physical memory map is defined using the memory.h API.  The
memory map consists of MemoryRegions pointing to guest RAM (or emulated
devices for MMIO/PIO hardware registers).

The APIs for accessing guest RAM are address_space_read/write(),
address_space_ld/st(), or memory_region_get_ram_ptr().  It's that last
function that can be used to translate a guest physical address to a
host virtual memory address.

For more info, see
http://blog.vmsplice.net/2016/01/qemu-internals-how-guest-physical-ram.html.

The guest CPU's memory management unit may support pagetables,
segmentation, or other memory translation mechanisms that translate
guest virtual addresses to guest physical addresses.  This is especially
relevant when the TCG just-in-time compiler is used to translate machine
instructions because it needs to implement a software MMU.  When
virtualization is used the guest MMU is implemented mostly in hardware.

Stefan

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0V2gYACgkQnKSrs4Gr
c8iZmwgAl4A7JNjx7T/kKjHsyHoG3NIFmJT1Ii/FVoX41BZIEDP1BcwXqJ11yFFf
HA5VfzUJ240xHeJ1PuyS67gtoZMzW3MNIWepDcg/uRKgNKlKAB1ndZLvmiB+G9Dh
attkfzPCFtVpG8pTTAn8HZAxfzzwoon8t8vYLXZFSjxzO2MddVG6jCX1xIJ3lEFu
lh6+bnzNGRB47lf6AyiQnlnczZaihcIUIbRfxNJ5+b+CMHTQksqF40AQ8kF4wYgH
eLpLxeOM7HedcLfWir6jM3fVunKukkC/c5bSxiYNK75t0Use0RhuQcQm/iLWJ+QP
9xasLWsCwVyYt4D0Q5k6PJS81nvfYw==
=4XJi
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

