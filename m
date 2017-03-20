Received: from eggs.gnu.org ([2001:4830:134:3::10]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sauravsachidanand@gmail.com>) id 1cq1EI-0002AH-F0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sauravsachidanand@gmail.com>) id 1cq1EH-0000Xu-Nf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:36:26 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sauravsachidanand@gmail.com>)
	id 1cq1EH-0000XV-Hh
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:36:25 -0400
Received: by mail-wr0-x233.google.com with SMTP id u48so97223129wrc.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 10:36:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170320173258.3621-1-sauravsachidanand@gmail.com>
References: <20170320173258.3621-1-sauravsachidanand@gmail.com>
From: Saurav Sachidanand <sauravsachidanand@gmail.com>
Date: Mon, 20 Mar 2017 17:36:23 +0000
Message-ID: <CACKq+iXP8eE6XPbTfRTvpsbf1Mks36G5eKasM0Cowi41uj1_5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v4] util: Use
 g_malloc/g_free in envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Mon, Mar 20, 2017 at 5:32 PM, Saurav Sachidanand
<sauravsachidanand@gmail.com> wrote:
> Change malloc/strdup/free to g_malloc/g_strdup/g_free in
> util/envlist.c.
>
> Remove NULL checks for pointers returned from g_malloc and g_strdup
> as they exit in case of failure. Also, update calls to envlist_create
> to reflect this.
>
> Free array and array contents returned by envlist_to_environ using
> g_free in bsd-user/main.c and linux-user/main.c.
>
> Update comments to reflect change in semantics.
> ---

Sorry, forgot to sign it.
