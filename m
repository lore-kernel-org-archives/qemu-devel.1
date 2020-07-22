Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B99C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC69120709
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhURO01j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC69120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyFVq-0000lJ-SG
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 10:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyFV5-0000Jv-NR
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:13:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyFV2-0007q2-MD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595427213;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Vk+NgN6QMmKWpD/Sx7CFIfayURnJyhEgG63k72nHtcU=;
 b=NhURO01jGmMciOe11ZCQAOoAHdIWlF65AOrQJ1mP66xbZJ/K/05TykT4QBjBEl2SaWlRzL
 0Ikc26EE4vY6l10PNBmBZVp5XDpxWwRNleEBXCVOzYf9pKNN36fWHD3FsGjUNE9x6uE7q8
 3kTu4G8vYsrTAx/7KpxUFjbqSc3NGU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-tCcU0ts7N0Kx1SsrnbMrRw-1; Wed, 22 Jul 2020 10:13:28 -0400
X-MC-Unique: tCcU0ts7N0Kx1SsrnbMrRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7089E18A1DFD;
 Wed, 22 Jul 2020 14:13:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BDEB101E5AF;
 Wed, 22 Jul 2020 14:13:21 +0000 (UTC)
Date: Wed, 22 Jul 2020 15:13:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: https booting
Message-ID: <20200722141318.GJ2324845@redhat.com>
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
 <20200722122347.GF2324845@redhat.com>
 <20200722135538.wvblddvskp5j4wik@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200722135538.wvblddvskp5j4wik@sirius.home.kraxel.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: ipxe-devel@lists.ipxe.org,
 =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, qemu-devel@nongnu.org,
 crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 03:55:38PM +0200, Gerd Hoffmann wrote:
> > > How does edk2 handle the root ca problem?
> > 
> > There are two fw_cfg paths
> > 
> >   - etc/edk2/https/ciphers
> >   - etc/edk2/https/cacerts
> > 
> > The first sets the cipher algorithms that are permitted and their
> > priority, the second sets the CA certificate bundle.
> 
> Ok, ipxe should be able to fetch them.  Would be roughly the same as
> compiling in the certificates, except that they don't take up space in
> the rom and are much easier to update.



> 
> What is in cacerts?
> Basically /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem of the host
> machine?

Not that file exactly. Instead

   /etc/pki/ca-trust/extracted/edk2/cacerts.bin

which is the same certs, but in a different format:

[quote man update-ca-trust]
       The directory /etc/pki/ca-trust/extracted/edk2/ contains a
       CA certificate bundle ("cacerts.bin") in the "sequence of
       EFI_SIGNATURE_LISTs" format, defined in the UEFI-2.7
       specification, sections "31.4.1 Signature Database" and
       "EFI_CERT_X509_GUID". Distrust information cannot be
       represented in this file format, and distrusted certificates
       are missing from these files. File "cacerts.bin" contains CA
       certificates trusted for TLS server authentication.
[/quote]

On Fedora/RHEL  the "update-ca-trust" tool creates the file in this
format automatically now.

I don't know if that's a useful format for iPXE or not.

We could easily define etc/ipxe/https/{ciphers,cacerts} paths in a
different format if better suited for iPXE. Libvirt can set the right
path depending on whether its booting a VM with EDK2 vs legacy BIOS

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


