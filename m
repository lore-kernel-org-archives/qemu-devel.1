Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC8C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873B8224D4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbsZSNB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873B8224D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIahG-0002Mj-Ep
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaaN-0002US-Ht
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaaL-0004Ha-9R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600274828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0LKG1YKxt/3zUKXuTaCRFAy5rqBc0p5rbc3NArpcyE=;
 b=RbsZSNB1Iszx3XZoT/tex5xwrwdLsonyvd618lX7D1AORGuRMrMYcNCjHdZj0DhZ0sYQm6
 GZEKV0g8DAz076efIQSWIEj2mNiQQJTz4BawL5U7srR71LjZTxgnABawMme3HlR6EjcN01
 okQI43/Bjem3zCgIlqP3kclP74rfTCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-9PqgpOYBPqmYr0JPNj5Omw-1; Wed, 16 Sep 2020 12:47:03 -0400
X-MC-Unique: 9PqgpOYBPqmYr0JPNj5Omw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5141C80EF8A
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:47:02 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 420171002D42;
 Wed, 16 Sep 2020 16:46:59 +0000 (UTC)
Message-ID: <b665189d8343e29f96c6649f3d5309f9ff8af844.camel@redhat.com>
Subject: [RFC DOCUMENT 02/12] kubevirt-and-kvm: Add Components page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:46:57 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Components.md

# Components

This document describes the various components of the KubeVirt
architecture, how they fit together, and how they compare to the
traditional virtualization architecture (QEMU + libvirt).

## Traditional architecture

For the comparison to make sense, let's start by reviewing the
architecture used for traditional virtualization.

![libvirt architecture][Components-Libvirt]

(Image taken from the "[Look into libvirt][]" presentation by Osier
Yang, which is a bit old but still mostly accurate from a high-level
perspective.)

In particular, the `libvirtd` process runs with high privileges on
the host and is responsible for managing all VMs.

When asked to start a VM, the management process will

* Prepare the environment by performing a number of privileged
  operations upfront
* Set up CGroups
* Set up kernel namespaces
* Apply SELinux labels
* Configure network devices
* Open host files
* ...
* Start a non-privileged QEMU process in that environment

## Kubernetes

To understand how KubeVirt works, it's first necessary to have some
knowledge of Kubernetes.

In Kubernetes, every user workload runs inside [Pods][]. The pod is
the smallest unit of work that Kubernetes will schedule.

Some facts about pods:

* They consist of multiple containers
* The containers share a network namespace
* The containers have their own PID and mount namespace
* The containers have their own CGroups for CPU, memory, devices and
  so forth. They are controlled by k8s and can’t be modified from
  outside.
* Pods can be started with extended privileges (`CAP_NICE`,
  `CAP_NET_RAW`, root user, ...)
* The app in the pods can drop the privileges, but the pod can not
  drop them (`kubectl exec` gives you a shell with the full
  privileges).

Creating pods with elevated privileges is generally frowned upon, and
depending on the policy decided by the cluster administrator it might
be outright impossible.

## KubeVirt architecture

Let's now discuss how KubeVirt is structured.

![KubeVirt architecture][Components-Kubevirt]

The main components are:

* `virt-launcher`, a copy of which runs inside each pod besides QEMU
  and libvirt, is the unprivileged component responsible for
  receiving commands from other KubeVirt components and reporting
  back events such as VM crashes;
* `virt-handler` runs at the node level via a DaemonSet, and is the
  privileged component which takes care of the VM setup by reaching
  into the corresponding pod and modifying its namespaces;
* `virt-controller` runs at the cluster level and monitors the API
  server so that it can react to user requests and VM events;
* `virt-api`, also running at the cluster level, exposes a few
  additional APIs that only apply to VMs, such as the "console" and
  "vnc" actions.

When a KubeVirt VM is started:

* We request a Pod with certain privileges and resources from
  Kubernetes.
* The kubelet (the node daemon of kubernetes) prepares the
  environment with the help of a container runtime.
* A shim process (virt-launcher) is our main entrypoint in the pod,
  which starts libvirt
* Once our node-daemon (virt-handler) can reach our shim process, it
  does privileged setup from outside. It reaches into the namespaces
  and modifies their content as needed. We mostly have to modify the
  mount and network namespaces.
* Once the environment is prepared, virt-handler asks virt-launcher
  to start a VM via its libvirt component.

More information can be found in the [KubeVirt architecture][] page.

## Comparison

The two architectures are quite similar from the high-level point of
view: in both cases there are a number of privileged components which
take care of preparing an environment suitable for running an
unprivileged QEMU process in.

The difference, however, is that while libvirtd takes care of all
this setup itself, in the case of KubeVirt several smaller components
are involved: some of these components are privileged just as libvirtd
is, but others are not, and some of the tasks are not even performed
by KubeVirt itself but rather delegated to the existing Kubernetes
infrastructure.

## Use of libvirtd in KubeVirt

In the traditional virtualization scenario, `libvirtd` provides a
number of useful features on top of those available with plain QEMU,
including

* support for multiple clients connecting at the same time
* management of multiple VMs through a single entry point
* remote API access

KubeVirt interacts with libvirt under certain conditions that make
the features described above irrelevant:

* there's only one client talking to libvirt: `virt-handler`
* libvirt is only asked to manage a single VM
* client and libvirt are running in the same pod, no remote libvirt
  access

[Components-Kubevirt]: 
https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Components-Kubevirt.png
[Components-Libvirt]: 
https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Components-Libvirt.png
[KubeVirt architecture]: https://github.com/kubevirt/kubevirt/blob/master/docs/architecture.md
[Look into libvirt]: https://www.slideshare.net/ben_duyujie/look-into-libvirt-osier-yang
[Pods]: https://kubernetes.io/docs/concepts/workloads/pods/


