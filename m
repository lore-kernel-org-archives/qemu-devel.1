Received: from eggs.gnu.org ([209.51.188.92]:57716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gz7Y3-0005KR-SJ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 17:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gz7Kc-0001UJ-Hi
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 17:05:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
	id 1gz7Kc-0001JS-6Z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 17:05:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x1RM4C9A131907
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 22:05:25 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp2130.oracle.com with ESMTP id 2qtwkudm8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 22:05:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1RM5On2001406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 22:05:24 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1RM5O3B029573
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 22:05:24 GMT
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <b83ee802-1f9a-f379-f1bf-4e13bfd8a94f@oracle.com>
Date: Wed, 27 Feb 2019 16:05:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Nested SVM only enabled (by default) in pc-i440fx-2.1?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>

Hi all,

I noticed nested SVM is enabled only in pc-i440fx-2.1 (default is 
disabled); this was added when 2.1 was the latest:

	75d373ef97 ("target-i386: Disable SVM by default in KVM mode")

However, this change was not carried forward to newer machine types. Is 
this an oversight? Is there a reason we (still) need SVM disabled by 
default?

Default setting - target/i386/cpu.c:

	static PropValue kvm_default_props[] = {
	    { "kvmclock", "on" },
             ...
	    { "monitor", "off" },
	    { "svm", "off" },
	    { NULL, NULL },
	};

2.1 override - hw/i386/pc_piix.c:

	static void pc_compat_2_1_fn(MachineState *machine)
	{
	    pc_compat_2_2_fn(machine);
	    x86_cpu_change_kvm_default("svm", NULL);
	}

Thanks and best regards,
-Mark
