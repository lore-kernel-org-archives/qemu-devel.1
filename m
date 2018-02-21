Received: from eggs.gnu.org ([2001:4830:134:3::10]:58334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoZnq-0004NM-MA
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoZnn-000576-Ao
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:11:42 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eoZnm-000569-SL
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:11:39 -0500
Date: Wed, 21 Feb 2018 14:11:37 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180221191137.GA26084@flamenco>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<20180215212552.26997-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180215212552.26997-2-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] build-sys: fix -fsanitize=address check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Thu, Feb 15, 2018 at 22:25:47 +0100, Marc-André Lureau wrote:
> Since 218bb57dd79d6843e0592c30a82ea8c1fddc74a5, the -fsanitize=address
> check fails with:
> config-temp/qemu-conf.c:3:20: error: integer overflow in expression [-Werror=overflow]
>    return INT32_MIN / -1;
> 
> Interestingly, UBSAN check doesn't produce a compile time warning.
> Use a test that doesn't have compile time warnings, and make it
> specific to UBSAN check.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
