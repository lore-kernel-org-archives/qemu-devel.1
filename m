Received: from eggs.gnu.org ([209.51.188.92]:42151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gowBW-0000St-45
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gowBU-0002sc-A6
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:10:10 -0500
References: <20190130152434.17283-1-mreitz@redhat.com>
	<20190130152434.17283-7-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a3951f34-de0c-b2be-d2eb-5d3fc2df3173@redhat.com>
Date: Wed, 30 Jan 2019 15:10:01 -0500
MIME-Version: 1.0
In-Reply-To: <20190130152434.17283-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/10] iotests.py: Add is_str()
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



On 1/30/19 10:24 AM, Max Reitz wrote:
> On Python 2.x, strings are not always unicode strings.  This function
> checks whether a given value is a plain string, or a unicode string (if
> there is a difference).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index f51456fa63..3e91444b79 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -221,6 +221,12 @@ def image_size(img):
>      r = qemu_img_pipe('info', '--output=json', '-f', imgfmt, img)
>      return json.loads(r)['virtual-size']
>  
> +def is_str(val):
> +    if sys.version_info.major >= 3:
> +        return isinstance(val, str)
> +    else:
> +        return isinstance(val, str) or isinstance(val, unicode)
> +
>  test_dir_re = re.compile(r"%s" % test_dir)
>  def filter_test_dir(msg):
>      return test_dir_re.sub("TEST_DIR", msg)
> 

Scares me less.

Reviewed-by: John Snow <jsnow@redhat.com>
