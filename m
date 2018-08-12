Received: from eggs.gnu.org ([2001:4830:134:3::10]:41869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fovZk-00067v-R6
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fovZg-0007Qb-SG
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:58:52 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fovZg-0007Pk-Iv
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 14:58:48 -0400
Received: by mail-wm0-f47.google.com with SMTP id y9-v6so6712967wma.5
	for <qemu-devel@nongnu.org>; Sun, 12 Aug 2018 11:58:48 -0700 (PDT)
References: <20180806065344.7103-1-armbru@redhat.com>
	<20180806065344.7103-24-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f39973cf-3088-6c39-f13b-34af159120f7@redhat.com>
Date: Sun, 12 Aug 2018 12:02:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180806065344.7103-24-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 23/23] libqtest: Rename qtest_FOOv() to
 qtest_vFOO() for consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 06/08/2018 08:53, Markus Armbruster wrote:
> 13 of 13 C99 library function pairs taking ... or a va_list parameter
> are called FOO() and vFOO().  In QEMU, we sometimes call the one
> taking a va_list FOOv() instead.  Bad taste.  libqtest.h uses both
> spellings.  Normalize it to the standard spelling.

Probably the bad example here was g_strdupv and g_strjoinv.  Those
however are taking a NULL-terminated char** [1] so the example was
copied incorrectly.

Paolo

[1] In this case, it's NULL not NUL. :)
