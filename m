Received: from eggs.gnu.org ([209.51.188.92]:51284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj2zw-0001NF-4d
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj2zu-0003Jo-6b
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:13:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gj2zs-0003Iy-5O
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:13:48 -0500
Date: Mon, 14 Jan 2019 09:13:42 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190114141342.GA27530@flamenco>
References: <20190114104641.19186-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114104641.19186-1-alex.bennee@linaro.org>
Subject: Re: [Qemu-devel] [RFC PATCH] tests: use g_usleep instead of rem =
 sleep(time)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com

On Mon, Jan 14, 2019 at 10:46:41 +0000, Alex Bennée wrote:
> Relying on sleep to always return having slept isn't safe as a signal
> may have occurred. If signals are constantly incoming the program will
> never reach it's termination condition. This is believed to be the
> mechanism causing time outs for qht-test in Travis.
> 
> The glib g_usleep() deals with all of this for us so lets use it instead.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		E.
