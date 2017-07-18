Received: from eggs.gnu.org ([2001:4830:134:3::10]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXK5U-0004iZ-Fx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXK5Q-00011i-IO
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:26:20 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXK5Q-00011C-CA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:26:16 -0400
Received: by mail-pf0-x22f.google.com with SMTP id q85so5140065pfq.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:26:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-41-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2db6160f-7eea-5819-7d6d-61831468830e@twiddle.net>
Date: Mon, 17 Jul 2017 18:26:09 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-41-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 40/45] osdep: introduce
 qemu_mprotect_rwx/none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> +static int qemu_mprotect__osdep(void *addr, size_t size, int prot)
> +{
> +    void *start = QEMU_ALIGN_PTR_DOWN(addr, qemu_real_host_page_size);
> +    void *end = QEMU_ALIGN_PTR_UP(addr + size, qemu_real_host_page_size);

I'm not keen on this.  Any good reason for it as opposed to asserting that the 
inputs are already page aligned?


r~
