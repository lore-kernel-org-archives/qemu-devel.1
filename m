Received: from eggs.gnu.org ([209.51.188.92]:44683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gw82B-0007w3-FD
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gw82A-0002yx-Qm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:14:15 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gw82A-0002xq-Jq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:14:14 -0500
Received: by mail-wr1-f48.google.com with SMTP id i16so14384921wrs.13
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:14:13 -0800 (PST)
Date: Tue, 19 Feb 2019 17:14:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190219161409.7qzohiyfhv3qpafl@steredhat>
References: <20190219114609.1582-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190219114609.1582-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix error reporting for -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Feb 19, 2019 at 11:46:09AM +0000, Daniel P. Berrangé wrote:
> Error reporting for user_creatable_add_opts_foreach was changed so that
> it no longer called 'error_report_err' in:
> 
>   commit 7e1e0c11127bde81cff260fc6859690435c509d6
>   Author: Markus Armbruster <armbru@redhat.com>
>   Date:   Wed Oct 17 10:26:43 2018 +0200
> 
>     qom: Clean up error reporting in user_creatable_add_opts_foreach()
> 
> Some callers were updated to pass in "&error_fatal" but all the ones in
> qemu-img were left passing NULL. As a result all errors went to
> /dev/null instead of being reported to the user.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qemu-img.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
