Received: from eggs.gnu.org ([2001:4830:134:3::10]:58415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diFtS-0006XA-03
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diFtL-0000U3-Hp
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:11:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diFtL-0000Ti-93
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 375A619C339
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 08:10:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-18-marcandre.lureau@redhat.com>
Date: Thu, 17 Aug 2017 10:10:52 +0200
In-Reply-To: <20170727154126.11339-18-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 27 Jul 2017
	17:41:17 +0200")
Message-ID: <87h8x6obqr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/26] qapi: add conditions to SPICE
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Copying our resident SPICE maintainer Gerd.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add #if defined(CONFIG_SPICE) in generated code, and adjust the
> qmp/hmp code accordingly.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi-schema.json | 28 ++++++++++++++++++----------
>  qapi/event.json  | 12 ++++++++----
>  monitor.c        |  3 ---
>  qmp.c            | 16 ----------------
>  4 files changed, 26 insertions(+), 33 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 829c66f9eb..bcee3157b0 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1878,7 +1878,8 @@
>  { 'struct': 'SpiceBasicInfo',
>    'data': { 'host': 'str',
>              'port': 'str',
> -            'family': 'NetworkAddressFamily' } }
> +            'family': 'NetworkAddressFamily' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceServerInfo:
> @@ -1891,7 +1892,8 @@
>  ##
>  { 'struct': 'SpiceServerInfo',
>    'base': 'SpiceBasicInfo',
> -  'data': { '*auth': 'str' } }
> +  'data': { '*auth': 'str' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceChannel:
> @@ -1916,7 +1918,8 @@
>  { 'struct': 'SpiceChannel',
>    'base': 'SpiceBasicInfo',
>    'data': {'connection-id': 'int', 'channel-type': 'int', 'channel-id': =
'int',
> -           'tls': 'bool'} }
> +           'tls': 'bool'},
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceQueryMouseMode:
> @@ -1935,7 +1938,8 @@
>  # Since: 1.1
>  ##
>  { 'enum': 'SpiceQueryMouseMode',
> -  'data': [ 'client', 'server', 'unknown' ] }
> +  'data': [ 'client', 'server', 'unknown' ],
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SpiceInfo:
> @@ -1972,7 +1976,8 @@
>  { 'struct': 'SpiceInfo',
>    'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str', '*port=
': 'int',
>             '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str=
',
> -           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChan=
nel']} }
> +           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChan=
nel']},
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @query-spice:
> @@ -2017,7 +2022,8 @@
>  #    }
>  #
>  ##
> -{ 'command': 'query-spice', 'returns': 'SpiceInfo' }
> +{ 'command': 'query-spice', 'returns': 'SpiceInfo',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @BalloonInfo:
> @@ -5067,7 +5073,8 @@
>  # Since: 1.5
>  ##
>  { 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
> -  'base': 'ChardevCommon' }
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevSpicePort:
> @@ -5079,7 +5086,8 @@
>  # Since: 1.5
>  ##
>  { 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
> -  'base': 'ChardevCommon' }
> +  'base': 'ChardevCommon',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @ChardevVC:
> @@ -5133,8 +5141,8 @@
>                                         'testdev': 'ChardevCommon',
>                                         'stdio'  : 'ChardevStdio',
>                                         'console': 'ChardevCommon',
> -                                       'spicevmc' : 'ChardevSpiceChannel=
',
> -                                       'spiceport' : 'ChardevSpicePort',
> +                                       'spicevmc' : { 'type': 'ChardevSp=
iceChannel', 'if': 'defined(CONFIG_SPICE)' },
> +                                       'spiceport' : { 'type': 'ChardevS=
picePort', 'if': 'defined(CONFIG_SPICE)' },
>                                         'vc'     : 'ChardevVC',
>                                         'ringbuf': 'ChardevRingbuf',
>                                         # next one is just for compatibil=
ity
> diff --git a/qapi/event.json b/qapi/event.json
> index c8b8e9f384..ff59551914 100644
> --- a/qapi/event.json
> +++ b/qapi/event.json
> @@ -344,7 +344,8 @@
>  ##
>  { 'event': 'SPICE_CONNECTED',
>    'data': { 'server': 'SpiceBasicInfo',
> -            'client': 'SpiceBasicInfo' } }
> +            'client': 'SpiceBasicInfo' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SPICE_INITIALIZED:
> @@ -372,7 +373,8 @@
>  ##
>  { 'event': 'SPICE_INITIALIZED',
>    'data': { 'server': 'SpiceServerInfo',
> -            'client': 'SpiceChannel' } }
> +            'client': 'SpiceChannel' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SPICE_DISCONNECTED:
> @@ -397,7 +399,8 @@
>  ##
>  { 'event': 'SPICE_DISCONNECTED',
>    'data': { 'server': 'SpiceBasicInfo',
> -            'client': 'SpiceBasicInfo' } }
> +            'client': 'SpiceBasicInfo' },
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @SPICE_MIGRATE_COMPLETED:
> @@ -412,7 +415,8 @@
>  #      "event": "SPICE_MIGRATE_COMPLETED" }
>  #
>  ##
> -{ 'event': 'SPICE_MIGRATE_COMPLETED' }
> +{ 'event': 'SPICE_MIGRATE_COMPLETED',
> +  'if': 'defined(CONFIG_SPICE)' }
>=20=20
>  ##
>  # @MIGRATION:
> diff --git a/monitor.c b/monitor.c
> index a1773d5bc7..4bf6a3ea2e 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -970,9 +970,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
>   */
>  static void qmp_unregister_commands_hack(void)
>  {
> -#ifndef CONFIG_SPICE
> -    qmp_unregister_command(&qmp_commands, "query-spice");
> -#endif
>  #ifndef CONFIG_REPLICATION
>      qmp_unregister_command(&qmp_commands, "xen-set-replication");
>      qmp_unregister_command(&qmp_commands, "query-xen-replication-status"=
);
> diff --git a/qmp.c b/qmp.c
> index 2c90dacb56..90816ba283 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -130,22 +130,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
>      }
>  }
>=20=20
> -#ifndef CONFIG_SPICE
> -/*
> - * qmp-commands.hx ensures that QMP command query-spice exists only
> - * #ifdef CONFIG_SPICE.  Necessary for an accurate query-commands
> - * result.  However, the QAPI schema is blissfully unaware of that,
> - * and the QAPI code generator happily generates a dead
> - * qmp_marshal_query_spice() that calls qmp_query_spice().  Provide it
> - * one, or else linking fails.  FIXME Educate the QAPI schema on
> - * CONFIG_SPICE.
> - */
> -SpiceInfo *qmp_query_spice(Error **errp)
> -{
> -    abort();
> -};
> -#endif
> -
>  void qmp_cont(Error **errp)
>  {
>      BlockBackend *blk;

Same drill as for PATCH 16.

Commands you make conditional:

* query-spice

  Before the patch, we first register the unconditionally command in
  generated code (requires a stub), then conditionally unregister in
  qmp_unregister_commands_hack().

  Afterwards, we register only when CONFIG_SPICE.  The command fails
  exactly the same, with CommandNotFound.

  Improvement, because now query-qmp-schema is accurate, and we're one
  step close to killing qmp_unregister_commands_hack().

Command arguments you make conditional:

* chardev-add, chardev-change variants spicevmc, spiceport

  Before the patch, "spicevmc" and "spiceport" are valid values of
  "type", but char_get_class() can't map them to a QOM type name, and
  fails with "'FOO' is not a valid char driver name".

  Afterwards, they aren't valid values, and input_type_enum() rejects
  them with "Invalid parameter 'FOO'".  That error message could use
  improvement, but that's not this patch's problem.

Events you make conditional:

* SPICE_CONNECTED, SPICE_INITIALIZED, SPICE_DISCONNECTED,
  SPICE_MIGRATE_COMPLETED

Check for completeness by reviewing the case insensitive occurrences of
SPICE in the schema not covered by your patch:

* add_client

  Same rationale as for VNC (see my review of PATCH 16).  Good.

* query-chardev-backends

  No conditional, because ChardevBackendInfo member @name is 'str'.  I
  think it should be an enum instead, and then we'd need to make some
  values conditional.  Not this patch's problem.

* client_migrate_info

  Similar to set_password and expire_password, this is generic in
  theory, documented for just "remote display", and implemented just for
  SPICE, with a stub for !CONFIG_SPICE.  Okay for the same reasons
  set_password and expire_password are okay.

* set_password, expire_password

  Same rationale as for VNC (see my review of PATCH 16).  Okay.

Some of this analysis should perhaps be worked into the commit message.
