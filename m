Received: from eggs.gnu.org ([2001:4830:134:3::10]:34986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.poctavek@erigones.com>) id 1dlD17-000276-L6
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.poctavek@erigones.com>) id 1dlD12-00081D-RB
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:43:13 -0400
Received: from zimbra.entira.sk ([93.184.68.160]:33346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.poctavek@erigones.com>)
	id 1dlD12-0007xA-Fe
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:43:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.entira.sk (Postfix) with ESMTP id A80ED567ADD
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 13:42:59 +0200 (CEST)
Received: from zimbra.entira.sk ([127.0.0.1])
	by localhost (zimbra.entira.sk [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rVZG_ZTvnbG2 for <qemu-devel@nongnu.org>;
	Fri, 25 Aug 2017 13:42:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.entira.sk (Postfix) with ESMTP id C4ED0567AE1
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 13:42:58 +0200 (CEST)
Received: from zimbra.entira.sk ([127.0.0.1])
	by localhost (zimbra.entira.sk [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u6wTMexLB2bK for <qemu-devel@nongnu.org>;
	Fri, 25 Aug 2017 13:42:58 +0200 (CEST)
Received: from [10.0.1.28] (gw-vnet.erigones.com [86.110.232.234])
	by zimbra.entira.sk (Postfix) with ESMTPSA id 94725567ADD
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 13:42:58 +0200 (CEST)
From: =?UTF-8?Q?J=c3=a1n_Poctavek?= <jan.poctavek@erigones.com>
Message-ID: <8c62454c-828b-0f16-76dd-227d9c52af1d@erigones.com>
Date: Fri, 25 Aug 2017 13:42:55 +0200
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] wrong ioctl error handling on dirty pages sync?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi guys,

Maybe it is just my lack of understanding, this seems like a bug to me:

To get list of dirty pages, qemu calls kvm_vm_ioctl() with 
KVM_GET_DIRTY_LOG:
https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L494

and considers the ioctl call failed when -1 is returned.

But the kvm_vm_ioctl() itself returns -errno, not the -1 on error:
https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L2142

Thanks in advance for sheding some light into this for me.

Jan
