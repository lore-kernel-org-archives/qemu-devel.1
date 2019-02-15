Received: from eggs.gnu.org ([209.51.188.92]:58033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guacE-0003BW-3P
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guacC-0004DM-3P
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:21:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1guac9-0003Ku-Se
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:21:03 -0500
References: <20190215094502.32149-1-dgilbert@redhat.com>
	<20190215094502.32149-2-dgilbert@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5fba5929-0b26-5cbd-ca15-a3dd820f8950@redhat.com>
Date: Fri, 15 Feb 2019 11:20:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190215094502.32149-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] .travis.yml: Remove disable-uuid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org

On 15/02/2019 10.45, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Commit 315d3184525 turned --disable-uuid into a warning only; remove
> the check from Travis.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 95c554897b..8497f10951 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -90,7 +90,7 @@ matrix:
>  
>  
>      - env:
> -        - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-uuid --disable-libusb --disable-user --disable-replication"
> +        - CONFIG="--disable-linux-aio --disable-cap-ng --disable-attr --disable-brlapi --disable-libusb --disable-user --disable-replication"

Reviewed-by: Thomas Huth <thuth@redhat.com>
