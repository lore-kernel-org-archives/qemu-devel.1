Received: from eggs.gnu.org ([2001:4830:134:3::10]:60938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8Svz-0004S1-7d
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8Svu-0005PH-DW
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8Svu-0005Oo-74
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:54:14 -0400
Date: Tue, 17 Apr 2018 12:53:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417155320.GX29865@localhost.localdomain>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-18-ehabkost@redhat.com>
	<87vacqf3da.fsf@dusky.pond.sub.org>
	<20180417144256.GW29865@localhost.localdomain>
	<0be4a17b-33ba-cd51-1352-0592ca14cafd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be4a17b-33ba-cd51-1352-0592ca14cafd@redhat.com>
Subject: Re: [Qemu-devel] [RFC 17/18] validator.py script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Amador Pahim <apahim@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Apr 17, 2018 at 05:17:13PM +0200, Paolo Bonzini wrote:
> On 17/04/2018 16:42, Eduardo Habkost wrote:
> >> Should we introduce yet another markup language into QEMU?  (pardon the
> >> pun).
> > Fair question.  What are the existing markup languages in QEMU we
> > could use?
> > 
> > JSON is an option, but I believe YAML is more readable.
> 
> Isn't YAML actually a superset of JSON that adds "magic indent", bullet
> lists and a bunch of other stuff that you're not using?  You can still
> use JSON to express a complicated dictionary for example.

Things I like about YAML in comparison to JSON:
- Comments
- No need to count number of closing brackets or worry about
  trailing commas
- Convenient ways to write long strings without
  "\\"another layer of escaping syntax\\""

JSON is not a language for humans, YAML is.

-- 
Eduardo
