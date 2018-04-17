Received: from eggs.gnu.org ([2001:4830:134:3::10]:43211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8SMP-0000Sx-FQ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8SMK-0008H0-JZ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:17:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8SMK-0008GE-Di
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:17:28 -0400
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-18-ehabkost@redhat.com>
	<87vacqf3da.fsf@dusky.pond.sub.org>
	<20180417144256.GW29865@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0be4a17b-33ba-cd51-1352-0592ca14cafd@redhat.com>
Date: Tue, 17 Apr 2018 17:17:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180417144256.GW29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 17/18] validator.py script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Amador Pahim <apahim@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 17/04/2018 16:42, Eduardo Habkost wrote:
>> Should we introduce yet another markup language into QEMU?  (pardon the
>> pun).
> Fair question.  What are the existing markup languages in QEMU we
> could use?
> 
> JSON is an option, but I believe YAML is more readable.

Isn't YAML actually a superset of JSON that adds "magic indent", bullet
lists and a bunch of other stuff that you're not using?  You can still
use JSON to express a complicated dictionary for example.

Paolo
