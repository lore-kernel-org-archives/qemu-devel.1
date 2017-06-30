Received: from eggs.gnu.org ([2001:4830:134:3::10]:57233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQka2-0000gR-4i
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQkZx-00080T-Az
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:18:42 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33507)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQkZw-0007zw-VM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:18:37 -0400
Date: Thu, 29 Jun 2017 21:18:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630011835.GN13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865316837.17063.1608754834009945976.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 28, 2017 at 15:32:48 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
(snip)
>  /**
>   * DisasJumpType:
>   * @DISAS_NEXT: Next instruction in program order.
> @@ -33,6 +65,78 @@ typedef enum DisasJumpType {
>      DISAS_TARGET_9,
>      DISAS_TARGET_10,
>      DISAS_TARGET_11,
> +    DISAS_TARGET_12,
> +    DISAS_TARGET_13,
> +    DISAS_TARGET_14,
>  } DisasJumpType;

These belong in patch 3.

		E.
