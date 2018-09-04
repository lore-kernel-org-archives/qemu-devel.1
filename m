Received: from eggs.gnu.org ([2001:4830:134:3::10]:36323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fx2W8-0005hu-Ei
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 00:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fx2W0-0005HF-Bs
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 00:00:38 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fx2W0-0005Gy-5P
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 00:00:32 -0400
Received: by mail-pf1-x444.google.com with SMTP id b11-v6so998861pfo.3
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 21:00:31 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
	<20180903092644.25812-2-xiaoguangrong@tencent.com>
	<87ftyq35an.fsf@trasno.org>
	<f22690e3-63d0-16e5-b2bc-de29471d3d0b@gmail.com>
Message-ID: <05a122a4-de67-0c84-1f31-d767f24914c2@gmail.com>
Date: Tue, 4 Sep 2018 12:00:25 +0800
MIME-Version: 1.0
In-Reply-To: <f22690e3-63d0-16e5-b2bc-de29471d3d0b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/4] migration: do not
 flush_compressed_data at the end of each iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 09/04/2018 11:54 AM, Xiao Guangrong wrote:

> 
> We will call it only if xbzrle is also enabled, at this case, we will
> disable compression and xbzrle for the following pages, please refer
                      ^and use xbzrle

Sorry for the typo.
