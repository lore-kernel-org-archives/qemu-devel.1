Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9D2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D5F229C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAEqQZNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D5F229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIadG-0005OF-8j
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaZT-0001ma-BM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:46:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaZQ-0004CQ-IW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600274770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5sY9uNfINu8hL60bZpBLUdYoN/SHQ1Za1Ze88KLtyY=;
 b=dAEqQZNZRauiC8XD2R7Zj/LXmYjJm9lOzb6BUxTi9gwc3achqfSB3RdpgkSYUbPzSFvJ+X
 RE9EpruoSTg4TIid3NrSXQw+n93e7i/XmJGeNrzbd256yXIvPDFYyK/BaLV8TU38Y/ekRH
 dRRa3yFmvwCslqT0EjpllE4FxXMWYr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-RXsIiUonOnO1iYPUrlSJ0w-1; Wed, 16 Sep 2020 12:46:08 -0400
X-MC-Unique: RXsIiUonOnO1iYPUrlSJ0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA689CC2C
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:46:07 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E11EC1002D79;
 Wed, 16 Sep 2020 16:45:40 +0000 (UTC)
Message-ID: <940b43fe8b248ba0cc22f53d1e569551a2ce2482.camel@redhat.com>
Subject: [RFC DOCUMENT 01/12] kubevirt-and-kvm: Add Index page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:45:37 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
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

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Index.md

# KubeVirt and the KVM user space

This is the entry point to a series of documents which, together,
detail the current status of KubeVirt and how it interacts with the
KVM user space.

The intended audience is people who are familiar with the traditional
virtualization stack (QEMU plus libvirt), and in order to make it
more approachable to them comparisons, are included and little to no
knowledge of KubeVirt or Kubernetes is assumed.

Each section contains a short summary as well as a link to a separate
document discussing the topic in more detail, with the intention that
readers will be able to quickly get a high-level understading of the
various topics by reading this overview document and then dig further
into the specific areas they're interested in.

## Architecture

### Goals

* KubeVirt aims to feel completely native to Kubernetes users
  * VMs should behave like containers whenever possible
  * There should be no features that are limited to VMs when it would
    make sense to implement them for containers too
* KubeVirt also aims to support all the workloads that traditional
  virtualization can handle
  * Windows support, device assignment etc. are all fair game
* When these two goals clash, integration with Kubernetes usually
  wins

### Components

* KubeVirt is made up of various discrete components that interact
  with Kubernetes and the KVM user space
  * The overall design is somewhat similar to that of libvirt, except
    with a much higher granularity and many of the tasks offloaded to
    Kubernetes
  * Some of the components run at the cluster level or host level
    with very high privileges, others run at the pod level with
    significantly reduced privileges

Additional information: [Components][]

### Runtime environment

* QEMU expects its environment to be set up in advance, something
  that is typically taken care of by libvirt
* libvirtd, when not running in session mode, assumes that it has
  root-level access to the system and can perform pretty much any
  privileged operation
* In Kubernetes, the runtime environment is usually heavily locked
  down and many privileged operations are not permitted
  * Requiring additional permissions for VMs goes against the goal,
    mentioned earlier, to have VMs behave the same as containers
    whenever possible

## Specific areas

### Hotplug

* QEMU supports hotplug (and hot-unplug) of most devices, and its use
  is extremely common
* Conversely, resources associated with containers such as storage
  volumes, network interfaces and CPU shares are allocated upfront
  and do not change throughout the life of the workload
  * If the container needs more (or less) resources, the Kubernetes
    approach is to destroy the existing one and schedule a new one to
    take over its role

Additional information: [Hotplug][]

### Storage

* Handled through the same Kubernetes APIs used for containers
  * QEMU / libvirt only see an image file and don't have direct
    access to the underlying storage implementation
  * This makes certain scenarios that are common in the
    virtualization world very challenging: examples include hotplug
    and full VM snapshots (storage plus memory)
* It might be possible to remove some of these limitations by
  changing the way storage is exposed to QEMU, or even take advantage
  of the storage technologies that QEMU already implements and make
  them available to containers in addition to VMs.

Additional information: [Storage][]

### Networking

* Application processes running in VMs are hidden behind a network
  interface as opposed to local sockets and processes running in
  a separated user namespace
  * Service meshes proxy and monitor applications by means of
    socket redirection and classification on local ports and
    process identifiers. We need to aim for generic compatibility
  * Existing solutions replicate a full TCP/IP stack to pretend
    applications running in a QEMU instance are local. No chances
    for zero-copy and context switching avoidance
* Network connectivity is shared between control plane and workload
  itself. Addressing and port mapping need particular attention
* Linux capabilities granted to the pod might be minimal, or none
  at all. Live migration presents further challenges in terms of
  network addressing and port mapping

Additional information: [Networking][]

### Live migration

* QEMU supports live migration between hosts, usually coordinated by
  libvirt
* Kubernetes expects containers to be disposable, so the equivalent
  of live migration would be to simply destroy the ones running on
  the source node and schedule replacements on the destination node
* For KubeVirt, a hybrid approach is used: a new container is created
  on the target node, then the VM is migrated from the old container,
  running on the source node, to the newly-created one

Additional information: [Live migration][]

### CPU pinning

* CPU pinning is not handled by QEMU directly, but is instead
  delegated to libvirt
* KubeVirt figures out which CPUs are assigned to the container after
  it has been started by Kubernetes, and passes that information to
  libvirt so that it can perform CPU pinning

Additional information: [CPU pinning][]

### NUMA pinning

* NUMA pinning is not handled by QEMU directly, but is instead
  delegated to libvirt
* KubeVirt doesn't implement NUMA pinning at the moment

Additional information: [NUMA pinning][]

### Isolation

* For security reasons, it's a good idea to run each QEMU process in
  an environment that is isolated from the host as well as other VMs
  * This includes using a separate unprivileged user account, setting
    up namespaces and cgroups, using SELinux...
  * QEMU doesn't take care of this itself and delegates it to libvirt
* Most of these techniques serve as the base for containers, so
  KubeVirt can rely on Kubernetes providing a similar level of
  isolation without further intervention

Additional information: [Isolation][]

## Other tidbits

### Upgrades

* When libvirt is upgraded, running VMs keep using the old QEMU
  binary: the new QEMU binary is used for newly-started VMs as well
  as after VMs have been power cycled or migrated
* KubeVirt behaves similarly, with the old version of libvirt and
  QEMU remaining in use for running VMs

Additional information [Upgrades][]

### Backpropagation

* Applications using libvirt usually don't provide all information,
  eg. a full PCI topology, and let libvirt fill in the blanks
  * This might require a second step where the additional information
    is collected and stored along with the original one
* Backpropagation doesn't fit well in Kubernetes' declarative model,
  so KubeVirt doesn't currently perform it

Additional information: [Backpropagation][]

## Contacts and credits

This information was collected and organized by many people at Red
Hat, some of which have agreed to serve as point of contacts for
follow-up discussion.

Additional information: [Contacts][]

[Backpropagation]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Backpropagation.md
[CPU pinning]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/CPU-Pinning.md
[Components]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Components.md
[Contacts]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Contacts.md
[Hotplug]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Hotplug.md
[Isolation]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Isolation.md
[Live migration]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Live-Migration.md
[NUMA pinning]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/NUMA-Pinning.md
[Networking]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Networking.md
[Storage]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Storage.md
[Upgrades]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Upgrades.md


