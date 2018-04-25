Received: from eggs.gnu.org ([2001:4830:134:3::10]:52104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBhd-0003IG-OF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBhZ-0001vk-0S
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:06:45 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:43231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBhY-0001vX-S7
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:06:40 -0400
Received: by mail-qt0-x244.google.com with SMTP id l11-v6so25171114qtj.10
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 21:06:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc137d4a-334d-40cf-d8e6-ee924985bc0d@amsat.org>
Date: Wed, 25 Apr 2018 01:06:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/46] tests/tcg/multiarch: move most
 output to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> The default test run outputs to stdout so it can be re-directed.
> Errors are still reported to stderr.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/multiarch/test-mmap.c | 38 ++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
> index cdefadfa4c..fd6ecc4880 100644
> --- a/tests/tcg/multiarch/test-mmap.c
> +++ b/tests/tcg/multiarch/test-mmap.c
> @@ -57,7 +57,7 @@ void check_aligned_anonymous_unfixed_mmaps(void)
>  	uintptr_t p;
>  	int i;
>  
> -	fprintf (stderr, "%s", __func__);
> +	fprintf (stdout, "%s", __func__);
>  	for (i = 0; i < 0x1fff; i++)
>  	{
>  		size_t len;
> @@ -106,7 +106,7 @@ void check_aligned_anonymous_unfixed_mmaps(void)
>  		munmap (p4, len);
>  		munmap (p5, len);
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_large_anonymous_unfixed_mmap(void)
> @@ -115,7 +115,7 @@ void check_large_anonymous_unfixed_mmap(void)
>  	uintptr_t p;
>  	size_t len;
>  
> -	fprintf (stderr, "%s", __func__);
> +	fprintf (stdout, "%s", __func__);
>  
>  	len = 0x02000000;
>  	p1 = mmap(NULL, len, PROT_READ, 
> @@ -130,7 +130,7 @@ void check_large_anonymous_unfixed_mmap(void)
>  	/* Make sure we can read from the entire area.  */
>  	memcpy (dummybuf, p1, pagesize);
>  	munmap (p1, len);
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_aligned_anonymous_unfixed_colliding_mmaps(void)
> @@ -141,7 +141,7 @@ void check_aligned_anonymous_unfixed_colliding_mmaps(void)
>  	uintptr_t p;
>  	int i;
>  
> -	fprintf (stderr, "%s", __func__);
> +	fprintf (stdout, "%s", __func__);
>  	for (i = 0; i < 0x2fff; i++)
>  	{
>  		int nlen;
> @@ -180,7 +180,7 @@ void check_aligned_anonymous_unfixed_colliding_mmaps(void)
>  		munmap (p2, pagesize);
>  		munmap (p3, nlen);
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_aligned_anonymous_fixed_mmaps(void)
> @@ -194,7 +194,7 @@ void check_aligned_anonymous_fixed_mmaps(void)
>  	addr = mmap(NULL, pagesize * 40, PROT_READ | PROT_WRITE, 
>  		    MAP_PRIVATE | MAP_ANONYMOUS,
>  		    -1, 0);
> -	fprintf (stderr, "%s addr=%p", __func__, addr);
> +	fprintf (stdout, "%s addr=%p", __func__, addr);
>  	fail_unless (addr != MAP_FAILED);
>  
>  	for (i = 0; i < 40; i++)
> @@ -212,7 +212,7 @@ void check_aligned_anonymous_fixed_mmaps(void)
>  		munmap (p1, pagesize);
>  		addr += pagesize;
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_aligned_anonymous_fixed_mmaps_collide_with_host(void)
> @@ -225,8 +225,8 @@ void check_aligned_anonymous_fixed_mmaps_collide_with_host(void)
>  	/* Find a suitable address to start with.  Right were the x86 hosts
>  	 stack is.  */
>  	addr = ((void *)0x80000000);
> -	fprintf (stderr, "%s addr=%p", __func__, addr);
> -	fprintf (stderr, "FIXME: QEMU fails to track pages used by the host.");
> +	fprintf (stdout, "%s addr=%p", __func__, addr);
> +	fprintf (stdout, "FIXME: QEMU fails to track pages used by the host.");
>  
>  	for (i = 0; i < 20; i++)
>  	{
> @@ -243,7 +243,7 @@ void check_aligned_anonymous_fixed_mmaps_collide_with_host(void)
>  		munmap (p1, pagesize);
>  		addr += pagesize;
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_file_unfixed_mmaps(void)
> @@ -252,7 +252,7 @@ void check_file_unfixed_mmaps(void)
>  	uintptr_t p;
>  	int i;
>  
> -	fprintf (stderr, "%s", __func__);
> +	fprintf (stdout, "%s", __func__);
>  	for (i = 0; i < 0x10; i++)
>  	{
>  		size_t len;
> @@ -294,7 +294,7 @@ void check_file_unfixed_mmaps(void)
>  		munmap (p2, len);
>  		munmap (p3, len);
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_file_unfixed_eof_mmaps(void)
> @@ -304,7 +304,7 @@ void check_file_unfixed_eof_mmaps(void)
>  	uintptr_t p;
>  	int i;
>  
> -	fprintf (stderr, "%s", __func__);
> +	fprintf (stdout, "%s", __func__);
>  	for (i = 0; i < 0x10; i++)
>  	{
>  		p1 = mmap(NULL, pagesize, PROT_READ, 
> @@ -327,7 +327,7 @@ void check_file_unfixed_eof_mmaps(void)
>  		fail_unless (cp[pagesize - 4] == 0);
>  		munmap (p1, pagesize);
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_file_fixed_eof_mmaps(void)
> @@ -343,7 +343,7 @@ void check_file_fixed_eof_mmaps(void)
>  		    MAP_PRIVATE | MAP_ANONYMOUS,
>  		    -1, 0);
>  
> -	fprintf (stderr, "%s addr=%p", __func__, (void *)addr);
> +	fprintf (stdout, "%s addr=%p", __func__, (void *)addr);
>  	fail_unless (addr != MAP_FAILED);
>  
>  	for (i = 0; i < 0x10; i++)
> @@ -371,7 +371,7 @@ void check_file_fixed_eof_mmaps(void)
>  		munmap (p1, pagesize);
>  		addr += pagesize;
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void check_file_fixed_mmaps(void)
> @@ -384,7 +384,7 @@ void check_file_fixed_mmaps(void)
>  	addr = mmap(NULL, pagesize * 40 * 4, PROT_READ, 
>  		    MAP_PRIVATE | MAP_ANONYMOUS,
>  		    -1, 0);
> -	fprintf (stderr, "%s addr=%p", __func__, (void *)addr);
> +	fprintf (stdout, "%s addr=%p", __func__, (void *)addr);
>  	fail_unless (addr != MAP_FAILED);
>  
>  	for (i = 0; i < 40; i++)
> @@ -426,7 +426,7 @@ void check_file_fixed_mmaps(void)
>  		munmap (p4, pagesize);
>  		addr += pagesize * 4;
>  	}
> -	fprintf (stderr, " passed\n");
> +	fprintf (stdout, " passed\n");
>  }
>  
>  void checked_write(int fd, const void *buf, size_t count)
> 
