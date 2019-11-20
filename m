Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92294C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 22:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591CF20714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 22:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ns1Tf0tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591CF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXYGt-000246-FE
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 17:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iXYFP-0001Sw-GH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iXYFM-0002oX-DK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:14:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iXYFL-0002ny-Vo
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574288087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=4Xr3JYKdEgsqAdeJ+R+VygllyGzovoK5EGWWAic0S0A=;
 b=Ns1Tf0tp8Sjej2NQZJPlGUtHh+fxSikAPOdWAcuF0XZWGS6udB/4Ugor9S/O/6sHJ0ag63
 nKfkpMXvncZEu7QwkdTEdIKpmXwl18PfC0Ij6ije0NDxvvkpnjKMY3dctC5FrIiFnZHerL
 N2GIpxUjABsyylVd8TK/keGw+1VjGKQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-og60afPXPGq8WQOWz2Fi1Q-1; Wed, 20 Nov 2019 17:14:45 -0500
Received: by mail-wm1-f69.google.com with SMTP id l184so818656wmf.6
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 14:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5FiS4PULp5hrh6QtpoMQDJ91GDuCpCyy7pFiothuI2Q=;
 b=NMcfVz/vxg4BVp4TU2oADSz4h5E2puO/kbNeVyDk2XfkrpPIby9JMz9GOx+tJ/hSnR
 6HfVW2XJ6FhBA7IiDMEYOYNdX1jmAYPzkAqI8mEXRySgmp24Q/pvX+mAsOeLHXZNxHzu
 R/dWYncoq2FgZy4vVwrRes7J3S9SXFpPmnGDSJ+MJ+vf0fsPr6/gds5Y2Hpei1IK3K+c
 5JMs1l7bGlVpgQww+kmanWFTS+qFLUu4/xpmtTaFBVSENYExNbiKH8qx5jMOuMtEMVt+
 XmpkeEwG1qWYGkQkaP/AWU0znyQ5n6btvckGikAIZuDLnf7p1EKZ24Zo347HTSU3SgNC
 dlMQ==
X-Gm-Message-State: APjAAAWUSGLJBYbHe/HpFyldx+YN/nsYKHRE0ZOmLY3UvJgb+B5s3kVg
 6yJkFOcUmZVNBA8k2rlyCfyOoaReYoedvn0Sr09Nk/kyrS41myEw7E8+Oa0r1/Yve27Tqrv651p
 INxY4TpAG4N2671E=
X-Received: by 2002:adf:9786:: with SMTP id s6mr6761454wrb.188.1574288084075; 
 Wed, 20 Nov 2019 14:14:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGNnSsO8IXxPxWnNrtuxitTB5ENexeI8Ck/L6CEqX9c0cPoBsU5HxjQCuyHfS1dTDnYwL4sQ==
X-Received: by 2002:adf:9786:: with SMTP id s6mr6761420wrb.188.1574288083799; 
 Wed, 20 Nov 2019 14:14:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:dc24:9a59:da87:5724?
 ([2001:b07:6468:f312:dc24:9a59:da87:5724])
 by smtp.gmail.com with ESMTPSA id c4sm829753wrp.86.2019.11.20.14.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 14:14:43 -0800 (PST)
Subject: Re: [PATCH] target/i386: add VMX features to named CPU models
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20191120173753.8894-1-pbonzini@redhat.com>
 <20191120184533.GT3812@habkost.net>
 <a86d16e7-c738-9b4b-e29a-518d94f174e0@redhat.com>
 <20191120211526.GW3812@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <32679eab-e789-1c43-565c-e783baf6591e@redhat.com>
Date: Wed, 20 Nov 2019 23:14:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191120211526.GW3812@habkost.net>
Content-Language: en-US
X-MC-Unique: og60afPXPGq8WQOWz2Fi1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jiri Denemark <jdenemar@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/19 22:15, Eduardo Habkost wrote:
>=20
> For how long was this broken?  Jiri, was libvirt including +vmx
> in mode=3Dhost-model for a long time, or is this something recent?

Could that be related to making nested=3D1 the default in the kernel?  KVM =
has

static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2
*entry)
{
        if (func =3D=3D 1 && nested)
                entry->ecx |=3D bit(X86_FEATURE_VMX);
}

which would date the change to Linux 4.20 (December 2018).

Paolo


