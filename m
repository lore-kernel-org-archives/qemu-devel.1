Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83470C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C93C206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbSg67IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C93C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81sB-000685-JC
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dvossel@redhat.com>)
 id 1k81ex-00016K-Uo
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dvossel@redhat.com>)
 id 1k81ew-0001rZ-6x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597757292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Jc/FHGg9W1G1d073+gcDOeBwKd7oOfGwIEAo5gAYoYg=;
 b=LbSg67IEkCw5F3I4sEdQ0kBNJ/1N7jXwHaTHneIATEvekdQn2mLvTtLZERbSjKBKcz3Rap
 mDjuoLoJ8ZgScFj9JI9k5FGH/6oQ9dZ0acWbdfzv8Ahv2u4Xxrvzg+/m1hIMunOR/l9aXC
 csDcQ2xiE+g1n2AGeDG5CPbljr2y9yU=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Ah0vEqFuO9qcXkEriXFoaw-1; Tue, 18 Aug 2020 09:26:08 -0400
X-MC-Unique: Ah0vEqFuO9qcXkEriXFoaw-1
Received: by mail-vk1-f199.google.com with SMTP id h191so5570366vkh.13
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 06:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Jc/FHGg9W1G1d073+gcDOeBwKd7oOfGwIEAo5gAYoYg=;
 b=rtRdcsLRvT5aeH4zOlzy1XWOsE19WMuTji0aGsUxtsPJ65/ylgWNkk0ZmwS1wK9U/M
 7llbDiHqLeGY+CRQTrNMUy3nmNtcl1isG0qwf9bxKUZFEMKI/4hpSvcrGqr6nAgUuaXD
 InyaKoeraNhbZy13S6e0/65BjmkuoDe6FlDVZvu+f5V01nOOSW2ZP2YUtcIz70UI1+J4
 5SQxYsh3txWd5HYVdfGfR1rYXPwcOkSxA6MV5R2JsVCd42ILWu78u4ZMaqIZ7Mb0AaDX
 i2V+VL6IxeQhhwJuNPUIsa6q9DR8Py/ZZvXIhg7G7YXVNay4Uohs1JHskxuZ9FclpO/3
 P1zA==
X-Gm-Message-State: AOAM530J80Y7JRA501Co96xabtMIO1pTeO5hORpP+m8/bXr4ytf2TnW+
 YXlTXhuG4wutgCq8iT/eLOJxjszKGrHzvF0k5sE/k26ULntH15B6/JB/8BD4TAdD3O3h5PXW1m1
 mlN2SceE5JXWWYzQCraKDg+ebtteY0Mc=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr10293469uay.15.1597757167409; 
 Tue, 18 Aug 2020 06:26:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH3J0w5fXbxIgdnaJX32d5KE3xNFBj+rUY9+P6a2farf5c0OqPjYYWnRen3XomWpm99R6rkz6BY9tMtXFzVAM=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr10293434uay.15.1597757167080; 
 Tue, 18 Aug 2020 06:26:07 -0700 (PDT)
MIME-Version: 1.0
From: David Vossel <dvossel@redhat.com>
Date: Tue, 18 Aug 2020 09:25:56 -0400
Message-ID: <CAPjOJFsjqFg6jO==Y5ExhL2+mZXA0Z1vce2pmUCODLtyS6Z7Yw@mail.gmail.com>
Subject: guest agent public ssh key add/remove support?
To: qemu-devel@nongnu.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dvossel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000061b10d05ad26d44c"
Received-SPF: none client-ip=63.128.21.124; envelope-from=dvossel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Aug 2020 09:39:32 -0400
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
Cc: Michal Privoznik <mprivozn@redhat.com>,
 Fabian Deutsch <fdeutsch@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000061b10d05ad26d44c
Content-Type: text/plain; charset="UTF-8"

Hey,

- Quick background

I'm investigating a feature for the KubeVirt project [1] (virtual machines
on Kubernetes) and ran into an area that I think the qemu guest agent might
help us solve.

A common usage pattern for nearly every Iaas platform (AWS, GCP, OpenStack,
Azure) is the ability to inject public ssh keys into VMs in order to grant
access to the VM for automation tools (like ansible) and users. One of the
more straightforward ways to do this is using cloud-init, which injects ssh
keys at boot.

However, in KubeVirt we're interested in taking this a step further by
allowing public ssh keys to be dynamically granted and revoked on live
"running" VMs. To accomplish this, we need something for our control plane
to coordinate with that is running within the actual VM guest.

- Guest Agent SSH add/remove Support?

As a PoC, I cobbled together some guest agent exec and file write client
commands which can technically achieve the desired result of
adding/removing entries in a /home/<user>/.ssh/authorized_keys file. It's a
little unwieldy, but it works.

This got me thinking, an officially supported guest agent api for this ssh
key management would be really nice. There's already a somewhat related
precedent with the "guest-set-user-password" guest agent command.

So here's the question. What would you all think about the guest agent API
being expanded with new commands for adding/removing ssh public keys from
authorized_keys files?

Thanks
- David














1. https://github.com/kubevirt/kubevirt

--00000000000061b10d05ad26d44c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey,<div><br></div><div>- Quick background</div><div><br><=
/div><div>I&#39;m investigating a feature for the KubeVirt project [1] (vir=
tual machines on Kubernetes) and ran into an area that I think the qemu gue=
st agent might help us solve.</div><div><br></div><div>A common usage patte=
rn for nearly every Iaas platform (AWS, GCP, OpenStack, Azure) is the abili=
ty to inject public ssh keys into VMs in order to grant access to the VM fo=
r automation tools (like ansible) and users. One of the more straightforwar=
d ways to do this is using cloud-init, which injects ssh keys at boot.</div=
><div><br></div><div>However, in KubeVirt we&#39;re interested in taking th=
is a step further by allowing public ssh keys to be dynamically granted and=
 revoked on live &quot;running&quot; VMs. To accomplish this, we need somet=
hing for our control plane to coordinate with that is running within the ac=
tual VM guest.</div><div><br></div><div>- Guest Agent SSH add/remove Suppor=
t?</div><div><br></div><div>As a PoC, I cobbled together some guest agent e=
xec and file write client commands which can technically achieve the desire=
d result of adding/removing entries in a /home/&lt;user&gt;/.ssh/authorized=
_keys file. It&#39;s a little=C2=A0unwieldy, but it works.</div><div><br></=
div><div>This got me thinking, an officially supported guest agent api for =
this ssh key management would be really nice. There&#39;s already a somewha=
t related precedent with the &quot;guest-set-user-password&quot; guest agen=
t command.</div><div><br></div><div>So here&#39;s the question. What would =
you all=C2=A0think about the guest agent API being expanded with new comman=
ds for adding/removing ssh public keys from authorized_keys files?</div><di=
v><br></div><div>Thanks</div><div>- David</div><div><br></div><div><br></di=
v><div><br></div><div><br></div><div><br></div><div><br></div><div><br></di=
v><div><br></div><div><br></div><div><br></div><div><br></div><div><br></di=
v><div><br></div><div><br></div><div>1.=C2=A0<a href=3D"https://github.com/=
kubevirt/kubevirt">https://github.com/kubevirt/kubevirt</a></div></div>

--00000000000061b10d05ad26d44c--


