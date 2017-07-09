Received: from eggs.gnu.org ([2001:4830:134:3::10]:34209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJQd-0003we-LM
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJQa-0006XH-HG
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:07:43 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:33289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJQa-0006Vo-BT
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:07:40 -0400
Received: by mail-pf0-x233.google.com with SMTP id e7so39938049pfk.0
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 14:07:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <05815974-120e-ab46-b962-1d9b2b648aca@twiddle.net>
Date: Sun, 9 Jul 2017 11:07:35 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-22-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/22] tcg: enable per-thread TCG for
 softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> I was not sure about tci_regs. From code inspection it seems that
> they have to be per-thread, so I converted them, but I do not think
> anyone has ever tried to get MTTCG working with TCI.

Yes, those should be per-thread.

Really, they should be on the stack in tcg_qemu_tb_exec, but the helpers aren't 
really structured to support that.


r~
