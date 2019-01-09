Received: from eggs.gnu.org ([209.51.188.92]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghB95-00040I-O2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghB94-0002qO-Qk
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:31:35 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:46372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghB94-0002jE-J8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:31:34 -0500
Received: by mail-wr1-f47.google.com with SMTP id l9so7056339wrt.13
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 02:31:21 -0800 (PST)
References: <20190109085113.GA23677@paraplu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <16805fd6-6326-4acc-ee99-ac0899a8cf1e@redhat.com>
Date: Wed, 9 Jan 2019 11:31:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190109085113.GA23677@paraplu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Should the "props" be documented for QMP
 `object-add`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

Hi Kashyap,

On 1/9/19 9:51 AM, Kashyap Chamarthy wrote:
> I notice that the following QMP command:
> 
>     {
>       "execute":"object-add",
>       "arguments":{
>         "qom-type":"tls-creds-x509",
>         "id":"objlibvirt_migrate_tls0",
>         "props":{
>           "dir":"/etc/pki/qemu",
>           "endpoint":"server",
>           "verify-peer":true
>         }
>       }
>     }
> 
> ... is the same as its command-line equivalent:
> 
>     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes
> 
> That said, in qapi/misc.json "@object-add" doesn't document any of the
> "props".  Is it on purpose?  Maybe because it is a 1:1 mapping of the
> command-line `-object` (which _is_ documented in qemu-doc.texi).
> 
> Is it a good idea to send a patch to document the "props" in
> qapi/misc.json?  Or would it be needless duplication?

IMHO the 1:1 mapping is only obvious for developpers who implement such
commands and for 3rd party libs using QMP.
For end-users, a command-line comment is helpful.

This remind me of this patch:

https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06623.html

+/**
+ * QAuthZSimple:
+ *
+ * This authorization driver provides a simple mechanism
+ * for granting access based on an exact matched username.
+ *
+ * To create an instance of this class via QMP:
+ *
+ *  {
+ *    "execute": "object-add",
+ *    "arguments": {
+ *      "qom-type": "authz-simple",
+ *      "id": "authz0",
+ *      "parameters": {
+ *        "identity": "fred"
+ *      }
+ *    }
+ *  }
+ *
+ * Or via the command line
+ *
+ *   -object authz-simple,id=authz0,identity=fred
+ *
+ */

Regards,

Phil.
