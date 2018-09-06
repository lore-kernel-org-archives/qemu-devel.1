Received: from eggs.gnu.org ([2001:4830:134:3::10]:45197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxnVh-0005aQ-Tu
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fxnVd-0002z9-Ve
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:11:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fxnVd-0002uN-Oc
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 02:11:17 -0400
References: <20180906054340.28988-1-famz@redhat.com>
	<20180906054340.28988-4-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <799499aa-875c-9d9d-84e5-33d9dfe4de52@redhat.com>
Date: Thu, 6 Sep 2018 08:11:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180906054340.28988-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] slirp: Implement RFC2132 TFTP
 server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Gerd Hoffmann <kraxel@redhat.com>

On 2018-09-06 07:43, Fam Zheng wrote:
> This new usernet option can be used to add data for option 66 (tftp
> server name) in the BOOTP reply, which is useful in PXE based automatic
> OS install such as OpenBSD.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  net/slirp.c      | 12 ++++++++++--
>  qapi/net.json    |  5 ++++-
>  qemu-options.hx  |  7 ++++++-
>  slirp/bootp.c    | 13 +++++++++++++
>  slirp/bootp.h    |  1 +
>  slirp/libslirp.h |  1 +
>  slirp/slirp.c    |  2 ++
>  slirp/slirp.h    |  1 +
>  8 files changed, 38 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
