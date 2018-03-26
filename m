Received: from eggs.gnu.org ([2001:4830:134:3::10]:49130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0OIW-0006o2-5M
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0OIT-00064k-1B
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:20:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f0OIS-00064P-Sg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 05:20:08 -0400
References: <20180326090350.30014-1-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <887c150e-3b72-6f81-e3ce-84ce03f13dff@redhat.com>
Date: Mon, 26 Mar 2018 11:20:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180326090350.30014-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docker: Inline "prep_fail" in run script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 26.03.2018 11:03, Fam Zheng wrote:
> We don't source common.rc where prep_fail is defined, so spell out the
> commands and do what was intended.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/run | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/run b/tests/docker/run
> index 9dd362bb98..7aebf4b569 100755
> --- a/tests/docker/run
> +++ b/tests/docker/run
> @@ -29,7 +29,7 @@ export TEST_DIR=/tmp/qemu-test
>  mkdir -p $TEST_DIR/{src,build,install}
>  
>  # Extract the source tarballs
> -tar -C $TEST_DIR/src -xf $BASE/qemu.tar || prep_fail "Failed to untar source"
> +tar -C $TEST_DIR/src -xf $BASE/qemu.tar || { echo "Failed to untar source"; exit 2; }
>  if test -f $TEST_DIR/src/Makefile; then
>      export FEATURES="$FEATURES dtc"
>  fi

Reviewed-by: Thomas Huth <thuth@redhat.com>
