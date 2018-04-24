Received: from eggs.gnu.org ([2001:4830:134:3::10]:35477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fAzHa-00024l-06
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fAzHV-00089j-1N
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:51:02 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:38779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fAzHU-00086F-Q5
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:50:56 -0400
Date: Tue, 24 Apr 2018 16:50:53 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <20180424145053.GA21648@ruderich.org>
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
	<954f83a5-675c-c4ff-6c89-6f8eb820a806@redhat.com>
	<20180422094728.GB29670@ruderich.org>
	<68d7375c-ef2d-19ee-5bcd-cda8573c8492@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <68d7375c-ef2d-19ee-5bcd-cda8573c8492@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Apr 23, 2018 at 02:46:57PM -0500, Eric Blake wrote:
> Back-compat in the QMP interface matters.  The HMP interface, however,
> exists to serve humans not machines, and we can break it at will to
> something that makes more sense to humans.  So don't let HMP concerns
> hold you back from a sane interface.

I see. However I don't like breaking existing interfaces unless I
have to. In this case I think not having the optional parameters
is fine and the consistency between the existing memsave/pmemsave
functions is more important.

> Optional parameters are listed as '*name':'type' in the .json file,
> which tells the generator to create a 'has_name' bool parameter
> alongside the 'name' parameter in the C code for the QMP interface.  The
> HMP interface should then call into the QMP interface.
>
> Recent HMP patches that I've authored may offer some inspiration: commit
> 08fb10a added a new command, and commit dba4932 added an optional
> parameter to an existing command.

Thank you for the explanation, this looks straight-forward.

Do you have strong opinions regarding the optional parameters or
would you accept the patch as is (minus possible implementation
issues)? I like the symmetry to the existing functions (I noticed
that size can only be optional for pmemload because saving the
complete memory doesn't sound useful) and having to specify
size/offset doesn't hurt the caller too much.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
