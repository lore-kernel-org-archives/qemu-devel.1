Received: from eggs.gnu.org ([209.51.188.92]:55865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gob2t-0003ym-GM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gob2r-0005UY-IE
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:35:51 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-7-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d1590928-5836-6630-ca30-02ee9d5c6efd@redhat.com>
Date: Tue, 29 Jan 2019 16:35:32 -0500
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/9] iotests.py: Add is_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 1/23/19 9:46 AM, Max Reitz wrote:
> Strings can have various representations, this helper function checks
> whether a given value is in any of them.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index f51456fa63..29e4e3306f 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -221,6 +221,12 @@ def image_size(img):
>      r = qemu_img_pipe('info', '--output=json', '-f', imgfmt, img)
>      return json.loads(r)['virtual-size']
>  
> +def is_str(val):
> +    if sys.version_info.major >= 3:
> +        return isinstance(val, str) or isinstance(val, bytes)
> +    else:
> +        return isinstance(val, str) or isinstance(val, unicode)
> +

conflating bytes with strings under a function named "is_str()" makes me
nervous, but... I have no concrete objections beyond hypothetically
"What if people take this function name literally?"

*prays for 2.x support to get dropped*

Reviewed-by: John Snow <jsnow@redhat.com>
