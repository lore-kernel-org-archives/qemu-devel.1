Received: from eggs.gnu.org ([2001:4830:134:3::10]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ49z-00089K-Nz
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZ49u-0004yZ-RN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:17:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZ49u-0004xg-MA
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 18:17:50 -0500
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<58763C1D-20EB-4C1F-86EC-C9903F87BDB3@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97ae663a-f2d1-c45d-bb8d-8be352d8f84c@redhat.com>
Date: Wed, 1 Feb 2017 15:17:44 -0800
MIME-Version: 1.0
In-Reply-To: <58763C1D-20EB-4C1F-86EC-C9903F87BDB3@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>



On 01/02/2017 14:50, G 3 wrote:
> I was thinking maybe we should add Rich Text Format, or maybe even a
> word processing format like OpenOffice, or Microsoft Word to the list o=
f
> possible formats. These formats are super easy to use. No formatting
> rules to have to learn. All the user needs to do is just type up their
> contribute to the documentation in a word processor. The word processor
> would do all the formatting work. Tables, links, stylized text are all
> possible. This would allow us to export to other formats like HTML, PDF=
,
> and ascii text.

That's exactly what we _don't_ want.

We need documentation to be consistent.  RTF, OpenOffice, etc. are
presentation-based format (or at least 99% users use them as such), and
this automatically disqualifies them.  We don't want our documentation
to be a mixture of Arial, Times New Roman and Comic Sans depending on
the user that's contributing.  Besides, conversion of word processor
documents to HTML usually looks terrible.

The requirements for the format are:

* support for HTML and man as output formats, optionally PDF and text
* support for QEMU's usual submission workflow
* producing documentation with a consistent look
* tool support and extensibility
* being easy to use and not too obscure

in this order.  Based on this, the only formats we could plausibly use
are Texinfo (if only because that's what we use now), Markdown,
restructuredText, Docbook and Asciidoc.  The poll mentioned all of these
except Asciidoc, plus LaTeX as a "control group".

Paolo
