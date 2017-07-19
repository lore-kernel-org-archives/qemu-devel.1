Received: from eggs.gnu.org ([2001:4830:134:3::10]:51255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXcfC-0007QW-LW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXcf9-0003sj-Ih
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:16:26 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-3-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6ea7cf54-5dcd-5a91-f0a7-3a7b3b9a4bd4@twiddle.net>
Date: Tue, 18 Jul 2017 14:16:17 -1000
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/29] pci: remove superfluous parenthesis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/17/2017 08:09 PM, Philippe Mathieu-Daudé wrote:
>   #define IOTEST_TEST(i) (iotest_test[((i) % ARRAY_SIZE(iotest_test))])
>   #define IOTEST_TYPE(i) (iotest_type[((i) / ARRAY_SIZE(iotest_test))])

Looks like  array[(x)] is another candidate.

> -#define IOTEST_MAX_TEST (ARRAY_SIZE(iotest_test))
> -#define IOTEST_MAX_TYPE (ARRAY_SIZE(iotest_type))
> +#define IOTEST_MAX_TEST ARRAY_SIZE(iotest_test)
> +#define IOTEST_MAX_TYPE ARRAY_SIZE(iotest_type)


r~
