Received: from eggs.gnu.org ([2001:4830:134:3::10]:35423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXqUC-000590-0R
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXqU8-0004De-UZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXqU8-0004DT-OG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 11:01:56 -0400
References: <20170611074817.13621-1-sf@sfritsch.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4267b3f1-02d2-0342-f964-956ed8fe1f63@redhat.com>
Date: Wed, 19 Jul 2017 17:01:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170611074817.13621-1-sf@sfritsch.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

 Hi,

On 11.06.2017 09:48, Stefan Fritsch wrote:
> Sending a break on a serial console can be useful for debugging the
> guest. But not all chardev backends support sending breaks (only telnet
> and mux do). The chardev-send-break command allows to send a break even
> if using other backends.
> 
> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
> v2: added tests and Acked-by line
[...]
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 99e35ec15a..6dfa0c36e2 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -22,6 +22,7 @@ static int verbose;
>  static const char *hmp_cmds[] = {
>      "boot_set ndc",
>      "chardev-add null,id=testchardev1",
> +    "chardev-send-break testchardev2",
>      "chardev-remove testchardev1",
>      "commit all",
>      "cpu-add 1",

Did you use "testchardev2" here on purpose, or should that have been a
"testchardev1" instead? "testchardev2" is not a valid identifier in the
HMP test, so this might not exercise the code path that you might have
intended?

 Thomas
