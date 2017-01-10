Received: from eggs.gnu.org ([2001:4830:134:3::10]:51923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR2ha-0006Av-QL
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR2hY-0003AJ-6a
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:07:26 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR2hX-00039s-VZ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:07:24 -0500
Received: by mail-pf0-x241.google.com with SMTP id b22so13933506pfd.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 12:07:23 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295045990.19871.11762054544913756135.stgit@fimbulvetr.bsc.es>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d33cce84-b7b4-981b-688a-9d0bc4c51b91@twiddle.net>
Date: Tue, 10 Jan 2017 12:07:18 -0800
MIME-Version: 1.0
In-Reply-To: <148295045990.19871.11762054544913756135.stgit@fimbulvetr.bsc.es>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 1/7] exec: [tcg] Refactor flush of
 per-CPU virtual TB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12/28/2016 10:41 AM, Lluís Vilanova wrote:
> The function is reused in later patches.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  cputlb.c                |    2 +-
>  include/exec/exec-all.h |    6 ++++++
>  translate-all.c         |   14 +++++++++-----
>  3 files changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
