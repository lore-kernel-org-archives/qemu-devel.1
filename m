Received: from eggs.gnu.org ([2001:4830:134:3::10]:59874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZy5D-0000GN-K2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZy59-0001b4-Lm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:37:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZy59-0001at-Gf
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:37:27 -0400
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-5-f4bug@amsat.org>
	<9a30c2d7-b6b7-c6e9-1c70-0fd4a90bca0c@redhat.com>
	<9376a63ed1790a79dadaaf0aac72455f6e7e2942.camel@perches.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57f942b9-9d49-1006-52fa-50b9f4461ff9@redhat.com>
Date: Mon, 2 Jul 2018 14:37:22 +0200
MIME-Version: 1.0
In-Reply-To: <9376a63ed1790a79dadaaf0aac72455f6e7e2942.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 04/46] checkpatch: Recognize IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joe Perches <joe@perches.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Pasi Savanainen <pasi.savanainen@nixu.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org

On 29/06/2018 23:46, Joe Perches wrote:
>>>      ERROR: "foo * bar" should be "foo *bar"
>>>      #310: FILE: hw/ppc/ppc440_uc.c:564:
>>>      +        size = 8 * MiB * sh;
>>>      total: 1 errors, 0 warnings, 433 lines checked
> Does the linux kernel use these?
> I don't believe so.
> 

No, I'm not sure why you were CCed. :)

Paolo
