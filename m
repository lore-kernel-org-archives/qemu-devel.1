Received: from eggs.gnu.org ([2001:4830:134:3::10]:51770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gJZ0D-0004DM-MT
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gJZ0A-0008Ja-Im
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:08:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gJZ0A-0007q4-5W
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:08:46 -0500
Received: by mail-wm1-x344.google.com with SMTP id v24-v6so7131074wmh.3
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 23:08:35 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-8-stefanha@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9573c10a-f6d3-7673-2c6d-c47b7617972f@twiddle.net>
Date: Mon, 5 Nov 2018 07:08:30 +0000
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-8-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/8] target-alpha: use HTTPS git URL for
 palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Daniel Berrange <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 11/4/18 11:24 AM, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  pc-bios/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
