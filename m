Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76362C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70A02223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGfh2dI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70A02223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvs9-0006xz-HX
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kUvom-0003K6-6F
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kUvoj-0003Ce-4K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603216379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9ZwV/tf5JNtqs0ZOOxWmlgaNbW/78a96E+2wrbdYIc=;
 b=PGfh2dI98XfdsXtUXcqjYdXTwN2TFy2Ij9LtlyxVesi1ZHlkg64mi3zb5kWHT25QLw6/4e
 mj/OQK7Zw/pf884pPLfGfJ9W67HD/Br0MuGpeVHW2lkCLy3URGpW6fnWDsFmPcg4Zxe9f3
 tDadJtqCe32gCP9Ef/Xvl7MZ2cEePOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-T3368GoLNS6-Bs72DugSJQ-1; Tue, 20 Oct 2020 13:52:55 -0400
X-MC-Unique: T3368GoLNS6-Bs72DugSJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB8A01087D65;
 Tue, 20 Oct 2020 17:52:53 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 682DC5B4A3;
 Tue, 20 Oct 2020 17:52:46 +0000 (UTC)
Message-ID: <c0e7bd88bf64c0b22023810192fdb6e38d96fd97.camel@redhat.com>
Subject: Re: [PATCH v4 2/4] Jobs based on custom runners: build environment
 docs and playbook
From: Andrea Bolognani <abologna@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Alex
 =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 19:52:43 +0200
In-Reply-To: <20201019015003.1527746-3-crosa@redhat.com>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-3-crosa@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2020-10-18 at 21:50 -0400, Cleber Rosa wrote:
> +++ b/scripts/ci/setup/build-environment.yml
> @@ -0,0 +1,233 @@
> +---
> +- name: Installation of basic packages to build QEMU
> +  hosts: all
> +  tasks:

My Ansible-fu is a bit rusty at the moment, so please double-check my
claims and apologies in advance for the ones that I will get wrong O:-)

> +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> +      apt:
> +        update_cache: yes
> +        # Originally from tests/docker/dockerfiles/ubuntu1804.docker
> +        pkg:
> +          - ccache
> +          - clang

Instead of using the 'apt' module here, and the equivalent module
further down, you could just do

  package:
    name:
      - pkg1
      - pkg2
        ...
    state: present

every single time and let Ansible take care of the differences for
you.

> +      when: "ansible_facts['distribution'] == 'Ubuntu'"

Quoting the entire condition is not necessary, you can just have

  when: ansible_facts['distribution'] == 'Ubuntu'

or, my preference,

  when:
    - ansible_facts['distribution'] == 'Ubuntu'

which results in a nicer diff when you add/remove conditions.

> +    - name: Install packages to build QEMU on Ubuntu 18.04/20.04 on non-s390x
> +      apt:
> +        update_cache: yes
> +        pkg:
> +         - libspice-server-dev
> +         - libxen-dev

Indentation of list items is inconsistent here.

> +    - name: Install basic packages to build QEMU on FreeBSD 12.x
> +      pkgng:
> +        # Originally from packages on .cirrus.yml under the freebsd_12_task
> +        name: bash,curl,cyrus-sasl,git,glib,gmake,gnutls,gsed,nettle,ninja,perl5,pixman,pkgconf,png,usbredir

See above for 'pkgng' vs 'package', but at the very least this should
be

  pkgng:
    name:
      - bash
      - curl
        ...

or each time the list is touched the resulting diff is going to be
unmanageable.

> +    - name: Enable PowerTools repo on CentOS 8
> +      ini_file:
> +        path: /etc/yum.repos.d/CentOS-PowerTools.repo
> +        section: PowerTools
> +        option: enabled
> +        value: "1"
> +      when:
> +        - "ansible_facts['distribution'] == 'CentOS'"
> +        - "ansible_facts['distribution_major_version'] == '8'"

Another option would be to use

  command: 'dnf config-manager --set-enabled Stream-PowerTools -y'
  args:
    warn: no

but I have to admit the way you're doing it is very clever ;)

-- 
Andrea Bolognani / Red Hat / Virtualization


