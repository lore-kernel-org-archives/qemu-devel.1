Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE7C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8351F224B0
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va9DFOSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351F224B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIanq-0001sG-Eq
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaje-0006Ng-Jw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIajc-0005UB-DU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8feCEpuTZE0YcvdNOkcqmcuR3ndmH9+1Kkt/kHO1rys=;
 b=Va9DFOSa0OQ1rvAP6h4AOhqa5UPIL283/bKTA8YxPU0p6tOmIV/+3CHoKHkbcHaoFxRr6m
 H3T/SspoeZl+VGqzmhkhlK5MeX1F1bYznqWxIHD3h69N5BtXhPP36rgLWCQHANstCCpDGY
 bURIB2nADnyAarLOLgwCe7p/3dfiAmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-ImgTu0O3POqs2YtqBZHv1Q-1; Wed, 16 Sep 2020 12:56:40 -0400
X-MC-Unique: ImgTu0O3POqs2YtqBZHv1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E0EC802B4C
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:56:39 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 075A467CEF;
 Wed, 16 Sep 2020 16:56:33 +0000 (UTC)
Message-ID: <9958389c7e9cf0cd731d71d8b7e805b514618cf6.camel@redhat.com>
Subject: [RFC DOCUMENT 11/12] kubevirt-and-kvm: Add Backpropagation page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:56:31 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: vromanso@redhat.com, rmohr@redhat.com, crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Backpropagation.md

# Backpropagation

Whenever a partial VM configuration is submitted to libvirt, any missing
information is automatically filled in to obtain a configuration that's
complete enough to guarantee long-term guest ABI stability.

PCI addresses are perhaps the most prominent example of this: most management
applications don't include this information at all in the XML they submit to
libvirt, and rely on libvirt building a reasonable PCI topology to support the
requested devices.

For example, using a made-up YAML syntax for brevity, the input could look like

```yaml
devices:
  disks:
  - image: /path/to/image.qcow2
```

and the output could be augmented by libvirt to look like

```yaml
devices:
  controllers:
  - model: pcie-root-port
    address:
      type: pci
      domain: 0x0000
      bus: 0x00
      slot: 0x01
      function: 0x0
  disks:
  - image: /path/to/image.qcow2
    model: virtio-blk
    address:
      type: pci
      domain: 0x0000
      bus: 0x01
      slot: 0x00
      function: 0x0
```

This is where backpropagation comes in: the only version of the VM
configuration that is complete enough to guarantee a stable guest ABI is the
one that includes all information added by libvirt, so if the management
application wants to be able to make further changes to the VM it needs to
reflect the additional information back into its understanding of the VM
configuration somehow.

For applications like virsh and virt-manager, this is easy: they don't have
their own configuration format or even store the VM configuration, and
simply fetch it from libvirt and operate on it directly every single time.

oVirt, to the best of my knowledge, generates an initial VM configuration based
on the settings provided by the user, submits it to libvirt and then parses
back the augmented version, figuring out what information was added and
updating its database to match: if the VM configuration needs to be generated
again later, it will include all information present in the database, including
those that originated from libvirt rather than the user.

KubeVirt does not currently perform any backpropagation. There are two ways a
user can influence PCI address allocation:

* explicitly add a `pciAddress` attribute for the device, which will cause
  KubeVirt to pass the corresponding address to libvirt, which in turn will
  attempt to comply with the user's request;
* add the `kubevirt.io/placePCIDevicesOnRootComplex` annotation to the VM
  configuration, which will cause KubeVirt to provide libvirt with a
  fully-specified PCI topology where all devices live on the PCIe Root Bus.

In all cases but the one where KubeVirt defines the full PCI topology itself,
it's implicitly relying on libvirt always building the PCI topology in the
exact same way every single time in order to have a stable guest ABI. While
this works in practice, it's not something that libvirt actually guarantees:
once a VM has been defined, libvirt will never change its PCI topology, but
submitting the same partial VM configuration to different libvirt versions can
result in different PCI topologies.


