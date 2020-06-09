Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB31C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F1520734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Px1cP3hW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F1520734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifCY-00055A-N0
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jifB4-0003aC-IH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:24:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jifB3-0001IJ-I3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591712672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+Fw1Essfc+ljt+c7AIE86vlszCoGY2qlzITDZgrcrc=;
 b=Px1cP3hWWT5M/gHcFJsmM2vNOXx2SjCTSGTau+YFyd5Mf6MZeNn9oQ9pn0ImIO8AlBcSTV
 uNfPbnFEaY/xApldQzrhpbBuG2s+WLef3V+sCxol6jBHdgekgyF5ecCuQHKKFbs3Huk9/4
 t26MVxSCzMz2MEuKKSzvY6OafVruqkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-4W8RgeuCO1ul7qZrrh6ieA-1; Tue, 09 Jun 2020 10:24:27 -0400
X-MC-Unique: 4W8RgeuCO1ul7qZrrh6ieA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 854BC83DD19;
 Tue,  9 Jun 2020 14:24:25 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4CBE61169;
 Tue,  9 Jun 2020 14:24:10 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] TPM-TIS bios-tables-test
To: qemu-devel@nongnu.org, no-reply@patchew.org
References: <159171124889.14379.10327774755780970706@45ef0f9c86ae>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b7da908f-2632-fe87-fe24-302d0ba33480@redhat.com>
Date: Tue, 9 Jun 2020 16:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <159171124889.14379.10327774755780970706@45ef0f9c86ae>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, mst@redhat.com,
 lersek@redhat.com, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, marcandre.lureau@redhat.com, stefanb@linux.ibm.com,
 philmd@redhat.com, ardb@kernel.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 6/9/20 4:00 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200609125409.24179-1-eric.auger@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
runs fine on my side. I guess what is missing here is the dependency
quoted in the cover letter:
"acpi: tpm: Do not build TCPA table for TPM 2"

Thanks

Eric

> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> Looking for expected file 'tests/data/acpi/q35/TCPA.tis'
> Looking for expected file 'tests/data/acpi/q35/TCPA'
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/bios-tables-test.c:370:load_expected_aml: assertion failed: (exp_sdt.aml_file)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/bios-tables-test.c:370:load_expected_aml: assertion failed: (exp_sdt.aml_file)
> make: *** [check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    iotest-qcow2: 030
>   TEST    iotest-qcow2: 031
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=71e400be07f14cd09538753c536cf099', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-3bqmv5j2/src/docker-src.2020-06-09-09.46.26.7521:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=71e400be07f14cd09538753c536cf099
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-3bqmv5j2/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    14m23.108s
> user    0m9.457s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200609125409.24179-1-eric.auger@redhat.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


