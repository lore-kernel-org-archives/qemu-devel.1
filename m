Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54E3C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCC820737
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lw+ydhve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCC820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyJmk-0000Pv-U9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 14:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyJmC-0008QU-I3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:47:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyJmA-0000fh-9g
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595443652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZFvlng+9JDTnuzEBFgGzefe5+a3ZXUIylAgZhEQAqg=;
 b=Lw+ydhvehJvCHy/zUk7VbaCReQ+uNImkRZTHGac/0IEcrODP0yV/X4cvbLxKz8URXOJPAZ
 JMae2gQozWr5RbLtYECcMuZQw0pzWyYjFGiyiHei01iYobgiibe7EVsrillPDRzDj2XsCH
 efGWf1K+rR33UomyzSUnb39WKgNBCq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-yUrHAVstMFS2GVAefcTPAw-1; Wed, 22 Jul 2020 14:47:27 -0400
X-MC-Unique: yUrHAVstMFS2GVAefcTPAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07CED10059A4;
 Wed, 22 Jul 2020 18:47:26 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-129.ams2.redhat.com
 [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C60732E020;
 Wed, 22 Jul 2020 18:47:20 +0000 (UTC)
Subject: Re: https booting
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
 <20200722122347.GF2324845@redhat.com>
 <20200722135538.wvblddvskp5j4wik@sirius.home.kraxel.org>
 <20200722141318.GJ2324845@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <05b7332c-cea1-dacc-5082-ffbfb8fb13b5@redhat.com>
Date: Wed, 22 Jul 2020 20:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200722141318.GJ2324845@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: ipxe-devel@lists.ipxe.org, qemu-devel@nongnu.org, crobinso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/22/20 16:13, Daniel P. Berrangé wrote:
> On Wed, Jul 22, 2020 at 03:55:38PM +0200, Gerd Hoffmann wrote:
>>>> How does edk2 handle the root ca problem?
>>>
>>> There are two fw_cfg paths
>>>
>>>   - etc/edk2/https/ciphers
>>>   - etc/edk2/https/cacerts
>>>
>>> The first sets the cipher algorithms that are permitted and their
>>> priority, the second sets the CA certificate bundle.
>>
>> Ok, ipxe should be able to fetch them.  Would be roughly the same as
>> compiling in the certificates, except that they don't take up space in
>> the rom and are much easier to update.
> 
> 
> 
>>
>> What is in cacerts?
>> Basically /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem of the host
>> machine?
> 
> Not that file exactly. Instead
> 
>    /etc/pki/ca-trust/extracted/edk2/cacerts.bin
> 
> which is the same certs, but in a different format:
> 
> [quote man update-ca-trust]
>        The directory /etc/pki/ca-trust/extracted/edk2/ contains a
>        CA certificate bundle ("cacerts.bin") in the "sequence of
>        EFI_SIGNATURE_LISTs" format, defined in the UEFI-2.7
>        specification, sections "31.4.1 Signature Database" and
>        "EFI_CERT_X509_GUID". Distrust information cannot be
>        represented in this file format, and distrusted certificates
>        are missing from these files. File "cacerts.bin" contains CA
>        certificates trusted for TLS server authentication.
> [/quote]
> 
> On Fedora/RHEL  the "update-ca-trust" tool creates the file in this
> format automatically now.
> 
> I don't know if that's a useful format for iPXE or not.
> 
> We could easily define etc/ipxe/https/{ciphers,cacerts} paths in a
> different format if better suited for iPXE.

I agree.

The p11-kit extractor for edk2 was implemented in p11-kit commit range ba6ebb05fc0c..de963b96929b:

  https://github.com/p11-glue/p11-kit/commit/59054e4f9fe3
  https://github.com/p11-glue/p11-kit/commit/ee27f9153a14
  https://github.com/p11-glue/p11-kit/commit/de963b96929b

  https://github.com/p11-glue/p11-kit/pull/137
  https://github.com/p11-glue/p11-kit/pull/139

The dependent "update-ca-trust" changes are here:

  https://src.fedoraproject.org/rpms/ca-certificates/c/6220683f7640?branch=master
  https://src.fedoraproject.org/rpms/ca-certificates/c/34c0da9058d6?branch=master

I think these commits could be used as model for an "iPXE extractor" if necessary.

Thanks,
Laszlo

> Libvirt can set the right
> path depending on whether its booting a VM with EDK2 vs legacy BIOS
> 
> Regards,
> Daniel
> 


