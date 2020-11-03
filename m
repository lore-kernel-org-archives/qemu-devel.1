Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739B3C55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39B7206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCThYfQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39B7206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3fy-0002rk-My
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka3fJ-0002Lw-8x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ka3fH-0005PN-E0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604438186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/4mq1Vg2/NOPYhy2pPaYER9ePiTjO9vALMbpxMh0xA=;
 b=eCThYfQvnTMIiDbG69ZzjMZd7TSI/jQ+G6/IQqVE/jFKWpnMWSTlGOo57NW4mG6LWr/eor
 NvzX4Z9TLsI1lfAYr0GmdCkCAIlCAL8qDpZRdQsmUPVuZBJVCOgH6QsiSaZ6vBePjMJCsh
 LuQApwAiFJ811cM3w6FTb9FbYQPvmQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-merESRKhMSK3ivudazvqSw-1; Tue, 03 Nov 2020 16:16:17 -0500
X-MC-Unique: merESRKhMSK3ivudazvqSw-1
Received: by mail-wm1-f69.google.com with SMTP id u207so287970wmu.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J/4mq1Vg2/NOPYhy2pPaYER9ePiTjO9vALMbpxMh0xA=;
 b=rt1BmkHSW98s4qCkdfev77SrP10h3LbP2LGVa7yP5MW+gBmT4c+Iv5uUBAhaPCCLzh
 /ZUz7s8nsRsD6nUwfP1MiDIPnkt3mmnkcyBTzgU5BHPUIw72fF+LPnC+x55KUFW3G8lq
 Felihp946kN+1LbqN+r7sn3X+lpRM/jusZA5vEJRUhaPzD4P5CLPwgyqnDM3F6K2qA1z
 aZtGLBOeAMJHPiXgKRzonfoffaV5hGI6GpqU3DXDa34SYNaKjnVSWkWGv0kK55C1a+7F
 +9lYoRwpUgdgG9YtPbWYrOaV7yYQSereTfxv31ehPfDOKh+ySimIrgjRphwSBAUNoKUi
 VQ2g==
X-Gm-Message-State: AOAM530wTEE3vReN0+3Arh+PcnkmRWY2Onhp8+zvhflH+ZFsoNxoc+vM
 wJgoFMkTFnjF9RIpsAC+IT/SZxivn7ilFCIrQalVId6sPN0D/gcFBK8WXGYrWzjxUA7wK+Ii17g
 9QiFRIzSn4nL1nY0=
X-Received: by 2002:adf:b7c8:: with SMTP id t8mr29434576wre.143.1604438175921; 
 Tue, 03 Nov 2020 13:16:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZnWmkEcRdhY2CBh+vH0nkPpfTjAW506Wgx4r7PpO9npDpvOrhqMnGtneRyC3ldyTK+Zehuw==
X-Received: by 2002:adf:b7c8:: with SMTP id t8mr29434551wre.143.1604438175674; 
 Tue, 03 Nov 2020 13:16:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id o197sm16369wme.17.2020.11.03.13.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 13:16:14 -0800 (PST)
Subject: Re: [PATCH 1/1] acpi: Implement ACPI ERST support for guests
To: Eric DeVolder <eric.devolder@oracle.com>, qemu-devel@nongnu.org
References: <1603743573-9870-1-git-send-email-eric.devolder@oracle.com>
 <1603743573-9870-2-git-send-email-eric.devolder@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f19ffa32-4bfb-3b42-e0de-ff1f6177e8db@redhat.com>
Date: Tue, 3 Nov 2020 22:16:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1603743573-9870-2-git-send-email-eric.devolder@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: ehabkost@redhat.com, konrad.wilk@oracle.com, mst@redhat.com,
 imammedo@redhat.com, boris.ostrovsky@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 21:19, Eric DeVolder wrote:
> This changeset introduces support for the ACPI Error Record
> Serialization Table, ERST.
> 
> ERST is defined in [1], and the error records are defined
> according to [2].
> 
> This changeset generates the ACPI ERST table, which OSPM
> follows to program the associated ERST device. The ERST
> device occupies 8KiB of address space, with the first 8 bytes
> containing registers, and the remainder being an exchange
> buffer for reading/writing error records.
> 
> The ERST device contains two registers, ACTION and VALUE
> registers, following closely the ERST operations.
> 
> The ERST device only examines the record for the signature 'CPER',
> its record identifier, and bounds-checks the length against the size
> of the the CPER record header; otherwise all other record fields
> and payload are ignored.
> 
> There are two options for this device:
>   -global acpi-erst.size=X
>   -global acpi-erst.filename=Y
> The size X, if not specified, defaults to 64KiB, and must be within
> 64KiB and 1MiB.
> The filename Y, if not specified, defaults to "acpi-erst.backing".
> The ERST backing storage is not mapped into the guest address space,
> just the 8KiB programming area is mapped into the guest.
> 
> This has been utilized as a backend for the Linux pstore feature.
> 
> [1] ACPI 6.3 Specification, 18.3 Error Serialization
>      https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> 
> [2] UEFI 2.8 Specification, Appendix N Common Platform Error Record
>      https://uefi.org/sites/default/files/resources/UEFI_Spec_2_8_final.pdf

In addition to what Igor said, this really needs a test for the device 
(using qtest).  It doesn't have to be super fine-grained, but at least a 
smoke test that the action and value registers do what they mean for a 
sample error recording operation.

Paolo


