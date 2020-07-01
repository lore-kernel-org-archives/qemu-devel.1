Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F21C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E3120760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/hqvt6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E3120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqczo-000146-Ru
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqczE-0000dP-4Q
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:41:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqczC-0003ZN-AN
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593610872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWIEMuaa/6uCppivhJ0ihLS3Q0Xor5YKfbH7JAJdquo=;
 b=S/hqvt6MQw8wWUCBMx2BSEDJt2dMTqpncCPoyd+Pvvt2pl5Q6WZvhILAdIF+Z3AmaKkPN1
 oQIUByxkPIyh95LYDN6/F+CYGA1M2oNehDy4XpDF6wlgRo44NtGMaPAO1htF9g5kwCOMeQ
 a29LzMnhPQe+flCvKXAzd2GTrZInJB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-49jJOE5lN-uu-nlXF-LVZg-1; Wed, 01 Jul 2020 09:40:55 -0400
X-MC-Unique: 49jJOE5lN-uu-nlXF-LVZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D301107ACF7;
 Wed,  1 Jul 2020 13:40:54 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D96F7C1F8;
 Wed,  1 Jul 2020 13:40:53 +0000 (UTC)
Subject: Re: [PATCH 1/1] scripts/performance: Add dissect.py script
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, ldoktor@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com, luoyonggang@gmail.com
References: <20200701130433.1506-1-ahmedkhaledkaraman@gmail.com>
 <20200701130433.1506-2-ahmedkhaledkaraman@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <06a0026e-f7cc-9a15-bc0e-d6c6c4846caf@redhat.com>
Date: Wed, 1 Jul 2020 08:40:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701130433.1506-2-ahmedkhaledkaraman@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 8:04 AM, Ahmed Karaman wrote:
> Python script that dissects QEMU execution into three main phases:
> code generation, JIT execution and helpers execution.
> 
> Syntax:
> dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
>                   <target executable> [<target executable options>]
> 
> [-h] - Print the script arguments help message.
> 
> Example of usage:
> dissect.py -- qemu-arm coulomb_double-arm

Given the example usage...

> 
> Example output:
> Total Instructions:        4,702,865,362
> 
> Code Generation:             115,819,309	 2.463%
> JIT Execution:             1,081,980,528	23.007%
> Helpers:                   3,505,065,525	74.530%
> 
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>   scripts/performance/dissect.py | 165 +++++++++++++++++++++++++++++++++
>   1 file changed, 165 insertions(+)
>   create mode 100644 scripts/performance/dissect.py
> 
> diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.py
> new file mode 100644

...this should have the executable bit set.


> +def get_JIT_line(callgrind_data):
> +    """
> +    Search for the first instance of the JIT call in
> +    the callgrind_annoutate output when ran using --tree=caller

annotate

> +    This is equivalent to the self number of instructions of JIT.
> +
> +    Parameters:
> +    callgrind_data (list): callgrind_annotate output
> +
> +    Returns:
> +    (int): Line number
> +   """
> +    line = -1
> +    for i in range(len(callgrind_data)):
> +        if callgrind_data[i].strip('\n') and \
> +                callgrind_data[i].split()[-1] == "[???]":
> +            line = i
> +            break
> +    if line == -1:
> +        sys.exit("Couldn't locate the JIT call ... Exiting!")

We tend to avoid ! at the end of error messages (it can come across as 
shouting at the user).

> +    return line
> +
> +
> +def main():
> +    # Parse the command line arguments
> +    parser = argparse.ArgumentParser(
> +        usage='dissect.py [-h] -- '
> +        '<qemu executable> [<qemu executable options>] '
> +        '<target executable> [<target executable options>]')
> +
> +    parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
> +
> +    args = parser.parse_args()
> +
> +    # Extract the needed variables from the args
> +    command = args.command
> +
> +    # Insure that valgrind is installed
> +    check_valgrind = subprocess.run(
> +        ["which", "valgrind"], stdout=subprocess.DEVNULL)
> +    if check_valgrind.returncode:
> +        sys.exit("Please install valgrind before running the script!")

and again

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


