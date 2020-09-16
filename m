Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48682C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978C6224B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcwAeD3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978C6224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIamL-0000yo-KT
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIakN-0007aa-Of
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:57:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kIakL-0005bG-PN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 12:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600275448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDr4qOoYb3mzqxERLJcApn7qw7r/J6GOavh9dipUqUY=;
 b=VcwAeD3ZJgo1GB2r/XCYzz779B8ln78/jwMWjA+ET4wfwKhiS8XtEh6lrwutBrRl1QMqRC
 O2tVDEWn3XTKqT7WQsVNAGoGrBT3MsaslT+MUNDrXjE8KCdobTQdtT06Dz9I/fSctHvmTx
 zzjzBbNvr5C+ZpwPrBUJfaz/wJFeYnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-8ytRsxHMM3-8S5-kK7y8IA-1; Wed, 16 Sep 2020 12:57:27 -0400
X-MC-Unique: 8ytRsxHMM3-8S5-kK7y8IA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 286A656B59
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 16:57:26 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12F6660CD1;
 Wed, 16 Sep 2020 16:57:20 +0000 (UTC)
Message-ID: <945015baba37b50c4e730c4264e98b02c3fab73f.camel@redhat.com>
Subject: [RFC DOCUMENT 12/12] kubevirt-and-kvm: Add Contacts page
From: Andrea Bolognani <abologna@redhat.com>
To: libvir-list@redhat.com, qemu-devel@nongnu.org
Date: Wed, 16 Sep 2020 18:57:18 +0200
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

https://gitlab.com/abologna/kubevirt-and-kvm/-/blob/master/Contacts.md

# Contacts and credits

# Contacts

The following people have agreed to serve as points of contact for
follow-up discussion around the topics included in these documents.

## Overall

* Andrea Bolognani <<abologna@redhat.com>> (KVM user space)
* Cole Robinson <<crobinso@redhat.com>> (KVM user space)
* Roman Mohr <<rmohr@redhat.com>> (KubeVirt)
* Vladik Romanovsky <<vromanso@redhat.com>> (KubeVirt)

## Networking

* Alona Paz <<alkaplan@redhat.com>> (KubeVirt)
* Stefano Brivio <<sbrivio@redhat.com>> (KVM user space)

## Storage

* Adam Litke <<alitke@redhat.com>> (KubeVirt)
* Stefan Hajnoczi <<stefanha@redhat.com>> (KVM user space)

# Credits

In addition to those listed above, the following people have also
contributed to the documents or the discussion around them.

Ademar Reis, Adrian Moreno Zapata, Alice Frosi, Amnon Ilan, Ariel
Adam, Christophe de Dinechin, Dan Kenisberg, David Gilbert, Eduardo
Habkost, Fabian Deutsch, Gerd Hoffmann, Jason Wang, John Snow, Kevin
Wolf, Marc-André Lureau, Michael Henriksen, Michael Tsirkin, Paolo
Bonzini, Peter Krempa, Petr Horacek, Richard Jones, Sergio Lopez,
Steve Gordon, Victor Toso, Viviek Goyal.

If your name should be in the list above but is not, please know that
was an honest mistake and not a way to downplay your contribution!
Get in touch and we'll get it sorted out :)


