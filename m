Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C19C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE0820675
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYUtM82T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE0820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDKB-0005Y2-Cr
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJDJD-0004Pa-9A
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJDJC-0000Rb-42
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:35:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31050
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJDJC-0000Q5-0k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585647345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpaFOXMcvMv9KGGpSgI9MMJxoI92jHrg9VvBPUNKLZA=;
 b=IYUtM82Tz740JoWfVuo7CoKwwwxTqpOxFGOQA8h7iKMUzWjZB9VSKDcnKTF+zCpRbdMsb8
 ZxcCXfyqrixsmQeg1NDTmpVPzVXVXkJ3+0Xqu18FsofCsYT+1yJessdRUagPVKj3u+XRL7
 Qalm0Past0qxu4quWaxKOUlqIRU3dow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-ZZQQGsHiPd-jlrWQi69Y5Q-1; Tue, 31 Mar 2020 05:35:43 -0400
X-MC-Unique: ZZQQGsHiPd-jlrWQi69Y5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD638017DF;
 Tue, 31 Mar 2020 09:35:42 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78039D7688;
 Tue, 31 Mar 2020 09:35:38 +0000 (UTC)
Date: Tue, 31 Mar 2020 11:35:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Add stsi 3.2.2 tests
Message-ID: <20200331113535.6bbd434d.cohuck@redhat.com>
In-Reply-To: <20200331071456.3302-1-frankja@linux.ibm.com>
References: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
 <20200331071456.3302-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 03:14:56 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
> a bit more thorough.

s/thorough/thoroughly/ ?

> 
> In this test we set a custom name and uuid through the QEMU command
> line. Both parameters will be passed to the guest on a stsi subcode
> 3.2.2 call and will then be checked.
> 
> We also compare the configured cpu numbers against the smp reported
> numbers and if the reserved + configured add up to the total number
> reported.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> * Tabify on struct
> * Moved prefix_push up a bit
> * Replaced returns with goto out to pop prefix
> 
> ---
>  s390x/stsi.c        | 73 +++++++++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg |  1 +
>  2 files changed, 74 insertions(+)
> 

(...)

> +static void test_3_2_2(void)
> +{
> +	int rc;
> +	/* EBCDIC for "kvm-unit" */
> +	const uint8_t vm_name[] = { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, 0x89,
> +				    0xa3 };
> +	const uint8_t uuid[] = { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
> +				 0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
> +				 0x00, 0x03 };
> +	/* EBCDIC for "KVM/" */
> +	const uint8_t cpi_kvm[] = { 0xd2, 0xe5, 0xd4, 0x61 };
> +	const char *vm_name_ext = "kvm-unit-test";
> +	struct stsi_322 *data = (void *)pagebuf;
> +
> +	report_prefix_push("3.2.2");
> +
> +	/* Is the function code available at all? */
> +	if (stsi_get_fc(pagebuf) < 3) {
> +		report_skip("Running under lpar, no level 3 to test.");
> +		goto out;
> +	}
> +
> +	rc = stsi(pagebuf, 3, 2, 2);
> +	report(!rc, "call");
> +
> +	/* For now we concentrate on KVM/QEMU */
> +	if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm))) {
> +		report_skip("Not running under KVM/QEMU.");
> +		goto out;
> +	}
> +
> +	report(!memcmp(data->vm[0].uuid, uuid, sizeof(uuid)), "uuid");
> +	report(data->vm[0].conf_cpus == smp_query_num_cpus(), "cpu # configured");
> +	report(data->vm[0].total_cpus ==
> +	       data->vm[0].reserved_cpus + data->vm[0].conf_cpus,
> +	       "cpu # total == conf + reserved");
> +	report(data->vm[0].standby_cpus == 0, "cpu # standby");
> +	report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)),
> +	       "VM name == kvm-unit-test");
> +
> +	if (data->vm[0].ext_name_encoding != 2) {
> +		report_skip("Extended VM names are not UTF-8.");

Do we expect this to be anything other than UTF-8?

> +		goto out;
> +	}
> +	report(!memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext)),
> +		       "ext VM name == kvm-unit-test");
> +
> +out:
> +	report_prefix_pop();
> +}
> +
>  int main(void)
>  {
>  	report_prefix_push("stsi");
>  	test_priv();
>  	test_specs();
>  	test_fc();
> +	test_3_2_2();
>  	return report_summary();
>  }

(...)


