Received: from eggs.gnu.org ([2001:4830:134:3::10]:55681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIrp-0000JT-1U
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIrl-0007Wz-Rb
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:12:57 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfIrl-0007Wl-NQ
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:12:53 -0500
Received: by mail-qk0-x243.google.com with SMTP id s186so4461407qkb.1
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 20:12:53 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-4-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5693bb98-82fe-e7ed-1610-540edf7c4410@amsat.org>
Date: Sun, 19 Feb 2017 01:12:50 -0300
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/24] tests/test-cutils: Add missing
 qemu_strtol()... endptr checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 02/14/2017 07:25 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/test-cutils.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 20b0f59..71681dc 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -262,6 +262,7 @@ static void test_qemu_strtol_empty(void)
>      err = qemu_strtol(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtol_whitespace(void)
> @@ -275,6 +276,7 @@ static void test_qemu_strtol_whitespace(void)
>      err = qemu_strtol(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtol_invalid(void)
> @@ -288,6 +290,7 @@ static void test_qemu_strtol_invalid(void)
>      err = qemu_strtol(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtol_trailing(void)
> @@ -548,6 +551,7 @@ static void test_qemu_strtoul_empty(void)
>      err = qemu_strtoul(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoul_whitespace(void)
> @@ -561,6 +565,7 @@ static void test_qemu_strtoul_whitespace(void)
>      err = qemu_strtoul(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoul_invalid(void)
> @@ -574,6 +579,7 @@ static void test_qemu_strtoul_invalid(void)
>      err = qemu_strtoul(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoul_trailing(void)
> @@ -829,6 +835,7 @@ static void test_qemu_strtoll_empty(void)
>      err = qemu_strtoll(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoll_whitespace(void)
> @@ -842,6 +849,7 @@ static void test_qemu_strtoll_whitespace(void)
>      err = qemu_strtoll(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoll_invalid(void)
> @@ -855,6 +863,7 @@ static void test_qemu_strtoll_invalid(void)
>      err = qemu_strtoll(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoll_trailing(void)
> @@ -1113,6 +1122,7 @@ static void test_qemu_strtoull_empty(void)
>      err = qemu_strtoull(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoull_whitespace(void)
> @@ -1126,6 +1136,7 @@ static void test_qemu_strtoull_whitespace(void)
>      err = qemu_strtoull(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoull_invalid(void)
> @@ -1139,6 +1150,7 @@ static void test_qemu_strtoull_invalid(void)
>      err = qemu_strtoull(str, &endptr, 0, &res);
>
>      g_assert_cmpint(err, ==, -EINVAL);
> +    g_assert(endptr == str);
>  }
>
>  static void test_qemu_strtoull_trailing(void)
>
