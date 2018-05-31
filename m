Received: from eggs.gnu.org ([2001:4830:134:3::10]:35717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOKms-0005nU-JQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOKmp-0007lM-Gu
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:26:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOKmp-0007kD-8p
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:26:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so1263715wro.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:26:27 -0700 (PDT)
References: <20180530162349.31100-1-pbonzini@redhat.com>
	<b1cca715-e58f-0013-20fb-9470ce3b6137@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b392c798-1fb0-6512-386a-60d429965afc@redhat.com>
Date: Thu, 31 May 2018 12:26:12 +0200
MIME-Version: 1.0
In-Reply-To: <b1cca715-e58f-0013-20fb-9470ce3b6137@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qom: support orphan objects in
 object_get_canonical_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 31/05/2018 05:45, Alexey Kardashevskiy wrote:
> Well, this is correct indeed for the normal case when the result is used
> for internal business but for my task (show the owner of an MR or at least
> give a clue what to grep for) it will discard a partial path.
> 
> I guess I could print a typename if object_get_canonical_path() returns
> NULL, I'll repost v4.

Very good!

Paolo
