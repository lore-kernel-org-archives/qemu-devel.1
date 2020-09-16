Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1D7C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF4A223EA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cT6yQnEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF4A223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIal6-0007jl-0X
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaj5-0005gu-6m
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIaj3-0005Pg-09
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+O6WLASC27ERNsIXT1jU1ru1oZfhUqiSL3JzMSroZI=;
 b=cT6yQnEj/RAg/47SBtUuE/SLPYTvBrvq3TFN/wPzrwYnYXXmEuIW+SHC8scrf5IfeUeVwO
 wlm3haz6IpTvCcbRIl4Sh2nhOXFwsIvr1FG40+FEf68wHmuD1zJWysjWjNk12Cvx01HJVd
 NIA/l3P39dyLvMCb0dpmQAJBPRnEyx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-5WSoirIrOASikSlKR9D4KA-1; Wed, 16 Sep 2020 12:55:50 -0400
X-MC-Unique: 5WSoirIrOASikSlKR9D4KA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9318F1882FB3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:55:49 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2FA619D61;
 Wed, 16 Sep 2020 16:55:47 +0000 (UTC)
Message-ID: <e795a9ff0e52695368b5dc2cf1e326c8c45ccada.camel@redhat.com>
Subject: [RFC DOCUMENT 10/12] kubevirt-and-kvm: Add Upgrades page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:55:45 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.004
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

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Upgrades.md

# Upgrades

The KubeVirt installation and upgrade process are entirely controlled
by an [operator][], which is a common pattern in the Kubernetes
world. The operator is a piece of software running in the cluster and
managing the lifecycle of other components, in this case KubeVirt.

## The operator

What it does:

* Manages the whole KubeVirt installation
* Keeps the cluster actively in sync with the desired state
* Upgrades KubeVirt with zero downtime

## Installation

Install the operator:

```bash
$ LATEST=$(curl -L https://storage.googleapis.com/kubevirt-prow/devel/nightly/release/kubevirt/kubevirt/latest)
$ kubectl apply -f https://storage.googleapis.com/kubevirt-prow/devel/nightly/release/kubevirt/kubevirt/$(LATEST)/kubevirt-operator.yaml
$ kubectl get pods -n kubevirt
NAME                                      READY   STATUS    RESTARTS   AGE
virt-operator-58cf9d6648-c7qph            1/1     Running   0          69s
virt-operator-58cf9d6648-pvzw2            1/1     Running   0          69s
```

Trigger the installation of KubeVirt:

```bash
$ LATEST=$(curl -L https://storage.googleapis.com/kubevirt-prow/devel/nightly/release/kubevirt/kubevirt/latest)
$ kubectl apply -f https://storage.googleapis.com/kubevirt-prow/devel/nightly/release/kubevirt/kubevirt/${LATEST}/kubevirt-cr.yaml
$ kubectl get pods -n kubevirt
NAME                                      READY   STATUS    RESTARTS   AGE
virt-api-8bdd88557-fllhr                  1/1     Running   0          59s
virt-controller-55ccb8cdcb-5rtp6          1/1     Running   0          43s
virt-controller-55ccb8cdcb-v8kr9          1/1     Running   0          43s
virt-handler-67pns                        1/1     Running   0          43s
```

The process happens in two steps because the operator relies on the
KubeVirt [custom resource][] for information on the desired
installation, and will not do anything until that resource exists in
the cluster.

## Upgrade

The upgrading process is similar:

* Install the latest operator
* Reference the new version in the KubeVirt CustomResource to trigger
  the actual upgrade

```bash
$ kubectl.sh get kubevirt -n kubevirt kubevirt -o yaml
apiVersion: kubevirt.io/v1alpha3
kind: KubeVirt
metadata:
  name: kubevirt
spec:
  imageTag: v0.30
  certificateRotateStrategy: {}
  configuration: {}
  imagePullPolicy: IfNotPresent
```

Note the `imageTag` attribute: when present, the KubeVirt operator
will take steps to ensure that the version of KubeVirt that's
deployed on the cluster matches its value, which in our case will
trigger an upgrade.

The following chart explain the upgrade flow in more detail and shows
how the various components are affected:

![KubeVirt upgrade flow][Upgrades-Kubevirt]

KubeVirt is released as a complete suite: no individual
`virt-launcher` releases are planned. Everything is tested together,
everything is released together.

## QEMU and libvirt

The versions of QEMU and libvirt used for VMs are also tied to the
version of KubeVirt and are upgraded along with everything else.

* Migrations from old libvirt/QEMU to new libvirt/QEMU pairs are
  possible
* As soon as the new `virt-handler` and the new controller are rolled
  out, the cluster will only start VMIs with the new QEMU/libvirt
  versions

## Version compatibility

The virt stack is updated along with KubeVirt, which mitigates
compatibility concerns. As a rule of thumb, versions of QEMU and
libvirt older than a year or so are not taken into consideration.

Currently, the ability to perform backwards migation (eg. from a
newer version of QEMU to an older one) is not necessary, but that
could very well change as KubeVirt becomes more widely used.

[Upgrades-Kubevirt]: https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Images/Upgrades-Kubevirt.png
[custom resource]: https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/
[operator]: https://kubernetes.io/docs/concepts/extend-kubernetes/operator/


