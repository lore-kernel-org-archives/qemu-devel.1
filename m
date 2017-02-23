Received: from eggs.gnu.org ([2001:4830:134:3::10]:35379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhouwj.fi@gmail.com>) id 1cgvvh-0000Jq-RN
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhouwj.fi@gmail.com>) id 1cgvvh-0001bS-1I
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:07:41 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhouwj.fi@gmail.com>) id 1cgvvg-0001b0-Qp
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 11:07:40 -0500
Received: by mail-wm0-x230.google.com with SMTP id v186so176276477wmd.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 08:07:39 -0800 (PST)
MIME-Version: 1.0
From: wenjian zhou <zhouwj.fi@gmail.com>
Date: Fri, 24 Feb 2017 00:07:37 +0800
Message-ID: <CAMr0U-SDRjL=Y0+F5VRLvqQQ=y++KxTrDBh9x4=8E0m_TSOoeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu-ga: qemu-ga will be blocked when works with vss
 in windows sometimes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tomoki.sekiyama@hds.com, mdroth@linux.vnet.ibm.com, zhangyabin.zhang@huawei.com, lizhengui@huawei.com

Hello all,

Recently, I have been doing some tests with commond:guest-fsfreeze-freeze.
I found if the commond is sent to qemu-ga when copying a large file in a
windows guest,
qemu-ga may lose response.

According to some basic research, I noted it is always blocked by the
following code.
in ./qga/vss-win32/requester.cpp:

void requester_freeze(int *num_vols, ErrorSet *errset)
<cut>
out:
    if (vss_ctx.pVssbc) {
        vss_ctx.pVssbc->AbortBackup();                      <-------- never
return
    }
    requester_cleanup();
    CoUninitialize();
<cut>

So I wonder how to fix it.
Can we just remove this line?
Without it, it seems that everything is going well.
I'm so appreciated if someone can help me.

--
Thanks
Zhou
