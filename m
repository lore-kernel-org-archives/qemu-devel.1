Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CBC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D024920756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOB1hr9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D024920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqTL-0004l6-JN
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kHq7p-0003pL-Q1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kHq7l-0000m4-Su
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600096226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLYQJ5/fbDGOusyFbqZOXwKk9gdItY1EpICAY0lqkHk=;
 b=hOB1hr9XkVLuW+zJlS6L8fdZWLlfW7w5p4mOlbz1wIRk+AMz+9RE/yUVwTOO9LcsF2GBzw
 FhKX8PwzjlLb4dCWXS+6ppsWHE7oAjVggSDTvGlDyfXklaY5DT7RBlH+g7BvPB3+JFL8kO
 7glngF95t6TxZ+8i74phzYwfM3OKFTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-lRFiPXXYOhuer2tiAE3ttQ-1; Mon, 14 Sep 2020 11:09:53 -0400
X-MC-Unique: lRFiPXXYOhuer2tiAE3ttQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0960B80F054;
 Mon, 14 Sep 2020 15:09:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-38.ams2.redhat.com
 [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42C2660BE2;
 Mon, 14 Sep 2020 15:09:50 +0000 (UTC)
Subject: Re: [PULL 00/10] EDK2 firmware: Adopt the edk2-stable202008 release
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200914071720.1099898-1-philmd@redhat.com>
 <CAFEAcA8VLMgFeJOyhEmiabVeEFQ_C=0x9Bs+hq03Q5+QJzYO7w@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d859937d-9629-0c4c-651f-a1d2e83902e6@redhat.com>
Date: Mon, 14 Sep 2020 17:09:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8VLMgFeJOyhEmiabVeEFQ_C=0x9Bs+hq03Q5+QJzYO7w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/14/20 14:09, Peter Maydell wrote:
> On Mon, 14 Sep 2020 at 08:19, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> The following changes since commit 3d9f371b01067d9cec4d592920013012119397c8:
>>
>>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-fixes-100920-1' into staging (2020-09-12 22:54:32 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20200914
>>
>> for you to fetch changes up to 8fa3b7029f3c9f901cd6bb01004114c003432d9b:
>>
>>   tests: acpi: update "virt/SSDT.memhp" for edk2-stable202008 (2020-09-13 23:03:15 +0200)
>>
>> ----------------------------------------------------------------
>> EDK2 firmware: Adopt the edk2-stable202008 release
>>
>> Note from Laszlo Ersek [1] while addressing LP#1852196 [2]:
>>
>> Consume the following upstream edk2 releases:
>>
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201908
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202002
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202005
>>   https://github.com/tianocore/edk2/releases/tag/edk2-stable202008
>>
>> Worth mentioning (in random order):
>>
>> - various CVE fixes (see [2] and shortlog)
>> - OpenSSL-1.1.1g
>> - UEFI HTTPS Boot for ARM/AARCH64
>> - TPM2 for ARM/AARCH64
>> - VCPU hotplug with SMI
>> - support for Linux v5.7+ initrd and mixed mode loading
>> - Fusion-MPT SCSI driver in OVMF
>> - VMware PVSCSI driver in OVMF
>> - PXEv4 / PXEv6 boot possible to disable on the QEMU command line
>> - SEV-ES support
>>
>> The IA32 and X64 binaries are now smaller -- the reason is that Laszlo
>> built them with DevToolSet 9 (gcc-9) on RHEL7, and so this is the first
>> time they've undergone LTO (with the GCC5 edk2 toolchain settings).
>>
>> CI jobs results:
>>   https://gitlab.com/philmd/qemu/-/pipelines/189394120
>>   https://travis-ci.org/github/philmd/qemu/builds/726842542
>>   https://app.shippable.com/github/philmd/qemu/runs/866/summary/console
>>
>> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg738173.html
>> [2] https://bugs.launchpad.net/qemu/+bug/1852196
> 
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
> for any user-visible changes.

Thank you Phil and Peter, I've added a short note to
<https://wiki.qemu.org/ChangeLog/5.2#Miscellaneous>.

Laszlo


